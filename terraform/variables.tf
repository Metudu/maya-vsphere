variable "vsphere_user" {
  type = string
  description = "The vSphere user"
}
variable "vsphere_password" {
  type = string
  description = "The password for vSphere user"
  sensitive = true
}
variable "vsphere_server" {
  type = string
  description = "vSphere server to connect"
}
variable "datacenter" {
  type = string
  description = "The datacenter name"
}
variable "resource_pool" {
  type = string
  description = "The resource pool name"
}
variable "datastore" {
  type = string
  description = "The datastore name"
}
variable "network" {
  type = string
  description = "The network adapter name"
}

variable "machines" {
  type = map(object({
    customer_name = string
    template = string
    cpu = number
    memory = number
    disk = object({
      label = string
      size = number
    })
    ipv4_address = string
    ipv4_netmask = number
    ipv4_gateway = string
    dns_server_list = list(string)
    domain = string
  }))
  description = <<-EOF

  EOF
}