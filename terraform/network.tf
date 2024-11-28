data "vsphere_network" "network" {
  for_each      = tolist(var.network)
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}