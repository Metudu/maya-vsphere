resource "vsphere_virtual_machine" "virtual_machine" {
  for_each = var.machines

  name             = format("%s_EnQ_%s", each.value.customer_name, each.key)
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = each.value.cpu
  memory           = each.value.memory
  guest_id         = "otherLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = each.value.disk.label
    size  = each.value.disk.size
  }
  clone {
    template_uuid = lower(each.value.template) == "rocky" ? local.rocky_template : local.ubuntu_template
    customize {
      network_interface {
        ipv4_address = each.value.ipv4_address
        ipv4_netmask = each.value.ipv4_netmask
      }
      ipv4_gateway = each.value.ipv4_gateway
      dns_server_list = each.value.dns_server_list

      linux_options {
        host_name = format("%s-%s",lower(each.value.customer_name), lower(each.key))
        domain = each.value.domain
      }
    }
  }
}