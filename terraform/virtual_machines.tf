resource "vsphere_virtual_machine" "virtual_machine" {
  for_each = var.machines

  resource_pool_id = data.vsphere_resource_pool.pool[each.value.resource_pool].id
  datastore_id     = data.vsphere_datastore.datastore[each.value.datastore].id

  name     = each.key
  folder   = each.value.folder
  num_cpus = each.value.cpu
  memory   = each.value.memory

  dynamic "network_interface" {
    for_each = each.value.network
    content {
      network_id = data.vsphere_network.network[network.value].id
    }
  }

  dynamic "disk" {
    for_each = each.value.disk
    content {
      label = disk.value.label
      size  = disk.value.size
    }
  }

  dynamic "cdrom" {
    for_each = each.value.iso != null ? [1] : []
    content {
      datastore_id = iso.value.datastore
      path         = iso.value.path
    }
  }

  dynamic "clone" {
    for_each = each.value.template != null ? [1] : []
    content {
      template_uuid = data.vsphere_virtual_machine.template[template.value.template_name].id
      customize {
        dynamic "network_interface" {
          for_each = template.value.network_interface
          content {
            ipv4_address = network_interface.value.ipv4_address
            ipv4_netmask = network_interface.value.ipv4_netmask
          }
        }
        ipv4_gateway    = template.value.ipv4_gateway
        dns_server_list = template.value.dns_server_list

        linux_options {
          host_name = template.value.host_name
          domain    = template.value.domain
        }
      }
    }
  }
}