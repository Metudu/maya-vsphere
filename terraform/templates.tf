data "vsphere_virtual_machine" "ubuntu" {
  name          = "ubuntu"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "rocky" {
  name          = "rocky"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
