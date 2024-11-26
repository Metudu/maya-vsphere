resource "vsphere_virtual_machine" "virtual_machine" {
  for_each = var.machines

  resource_pool_id = data.vsphere_resource_pool.pool[index(var.resource_pool, each.value.resource_pool)].id
  datastore_id     = data.vsphere_datastore.datastore[index(var.datastore, each.value.datastore)].id

  name             = each.key
  folder           = each.value.folder 
  num_cpus         = each.value.cpu
  memory           = each.value.memory

  dynamic "network_interface" {
    for_each = {for value in var.machines.network: index(each.value.network, value) => value}
    content {
      network_id = data.vsphere_network.network[each.key].id
    }
  }

  dynamic "disk" {
    for_each = var.machines.disk
    content {
      label = each.value.label
      size  = each.value.size
    }
  }
  
  cdrom {
    datastore_id = each.value.iso.datastore
    path = each.value.iso.path
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template[index(var.templates, each.value.template.template_name)].id
    customize {
      dynamic "network_interface" {
        for_each = each.value.template.network_interface
        content {
          ipv4_address = each.value.ipv4_address
          ipv4_netmask = each.value.ipv4_netmask
        }
      }
      ipv4_gateway = each.value.template.ipv4_gateway
      dns_server_list = each.value.template.dns_server_list

      linux_options {
        host_name = each.value.template.host_name
        domain = each.value.template.domain
      }
    }
  }
}