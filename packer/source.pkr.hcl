source "vsphere-clone" "image" {
  communicator        = "ssh"
  insecure_connection = "true"
  template            = "Packer-VM-Image"
  vm_name             = "Packer-Clone-Machine"
  host                = var.host
  password            = var.password
  username            = var.username
  vcenter_server      = var.vcenter_server
  convert_to_template = true
}

variable "host" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "vcenter_server" {
  type = string
}