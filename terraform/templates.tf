data "vsphere_virtual_machine" "template" {
  for_each      = var.templates
  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}