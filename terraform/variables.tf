variable "vsphere_user" {
  type        = string
  description = "The vSphere user"
}

variable "vsphere_password" {
  type        = string
  description = "The password for vSphere user. You may want to store this variable in a .auto.tfvars file in order to use it secretly."
  sensitive   = true
}

variable "vsphere_server" {
  type        = string
  description = "vSphere server to connect"
}

variable "datacenter" {
  type        = string
  description = "The datacenter name. Currently, using only one datacenter is supported."
}

variable "resource_pool" {
  type        = set(string)
  description = "Set of the resource pool names. You need to import all the resource pools you will use to create the virtual machines."
}

variable "datastore" {
  type        = set(string)
  description = "Set of the datastore names. You need to import all the datastores you will use to either create a virtual machine or access the ISO file stored in the datastore."
}

variable "network" {
  type        = set(string)
  description = "Set of the network adapter names. You need to import all the network adapters you will use to create the virtual machines."
}

variable "templates" {
  type = set(string)
  description = "Set of the template names, use if any template will be used to create a virtual machine."
  default = null
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