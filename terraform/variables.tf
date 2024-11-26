variable "vsphere_user" {
  type        = string
  description = "The vSphere user"
}

variable "vsphere_password" {
  type        = string
  description = "The password for vSphere user"
  sensitive   = true
}

variable "vsphere_server" {
  type        = string
  description = "vSphere server to connect"
}

variable "datacenter" {
  type        = string
  description = "The datacenter name"
}

variable "resource_pool" {
  type        = set(string)
  description = "The resource pool name"
}

variable "datastore" {
  type        = set(string)
  description = "The datastore name"
}

variable "network" {
  type        = set(string)
  description = "The network adapter name"
}

variable "templates" {
  type = set(string)
  description = "Template machine names, if any template will be used to create a virtual machine."
  default = []
}

variable "machines" {
  type = map(object({
    // Machine resources
    resource_pool = string
    datastore = string
    network = set(string)
    folder  = string

    cpu      = number
    memory   = number

    disk = set(object({
      label = string
      size  = number
    }))

    iso = optional(object({
      datastore = string
      path = string
    }))

    template = optional(object({
      template_name = string
      network_interface = set(object({
        ipv4_address = string
        ipv4_netmask = number
      }))
      ipv4_gateway    = string
      dns_server_list = list(string)
      domain          = string
      host_name       = string
    }))
  }))

  description = <<-EOF

  EOF
}