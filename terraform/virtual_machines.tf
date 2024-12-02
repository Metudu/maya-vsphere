resource "vsphere_virtual_machine" "virtual_machine" {
  for_each = var.machines

  resource_pool_id = data.vsphere_resource_pool.pool[each.value.resource_pool].id
  datastore_id     = data.vsphere_datastore.datastore[each.value.datastore].id

  name     = each.key
  folder   = each.value.folder
  num_cpus = each.value.cpu
  memory   = each.value.memory
  guest_id = lookup(each.value, "template", null) != null ? data.vsphere_virtual_machine.template[lookup(each.value.template, "template_name", null)].guest_id : null

  dynamic "network_interface" {
    for_each = each.value.network
    content {
      network_id = data.vsphere_network.network[network_interface.value].id
    }
  }

  dynamic "disk" {
    for_each = each.value.disk
    content {
      label = disk.value.label
      size  = disk.value.size
      unit_number = index(tolist(each.value.disk), disk.value)
    }
  }

  dynamic "cdrom" {
    for_each = each.value.iso != null ? [1] : []
    content {
      datastore_id = lookup(cdrom, "datastore", null)
      path         = lookup(cdrom, "path", null)
    }
  }

  dynamic "clone" {
    for_each = lookup(each.value, "template", null)[*]
    content {
      template_uuid = data.vsphere_virtual_machine.template[clone.value.template_name].id
      customize {
        dynamic "network_interface" {
          for_each = clone.value.network_interface
          content {
            ipv4_address = network_interface.value.ipv4_address
            ipv4_netmask = network_interface.value.ipv4_netmask
          }
        }
        ipv4_gateway    = clone.value.ipv4_gateway
        dns_server_list = clone.value.dns_server_list

        linux_options {
          host_name = clone.value.host_name
          domain    = clone.value.domain
        }
      }
    }
  }
}