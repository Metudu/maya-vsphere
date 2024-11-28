data "vsphere_resource_pool" "pool" {
  for_each      = tolist(var.resource_pool)
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}