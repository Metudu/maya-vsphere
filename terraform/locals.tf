locals {
  rocky_template = data.vsphere_virtual_machine.rocky.id
  ubuntu_template = data.vsphere_virtual_machine.ubuntu.id
}