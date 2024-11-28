data "vsphere_datastore" "datastore" {
  for_each      = tolist(var.datastore)
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}