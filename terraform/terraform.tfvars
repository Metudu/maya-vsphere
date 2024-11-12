vsphere_server = ""
vsphere_user = ""
vsphere_password = ""

datacenter = ""
resource_pool = ""
datastore = ""
network = ""

machines = {
  "AI01" = {
    cpu = 2
    customer_name = "Test"
    disk = {
      label = "Hard Disk 1"
      size = 20
    }
    dns_server_list = [ "8.8.8.8" ]
    domain = ""
    ipv4_address = "10.0.0.10"
    ipv4_gateway = "10.0.0.1"
    ipv4_netmask = 24
    memory = 4096
    template = "ubuntu"
  },
  "AIAPP01" = {
    
  },
  "AIAPP02" = {
    
  },
  "APP01" = {
    
  },
  "APP02" = {
    
  },
  "MAP01" = {
    
  },
  "MAP02" = {
    
  },
  "FileServer" = {
    
  },
  "PSQL01" = {

  },
  "VideoResize01" = {

  },
  "VideoResize02" = {

  }
}