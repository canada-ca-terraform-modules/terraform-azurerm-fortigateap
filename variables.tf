variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "envprefix" {
  description = "Prefix for the environment"
  default     = "Demo"
}

variable "secretPasswordName" {
  description = "Name of Keuvault secrets containing the desired firewall password"
}

variable "tags" {
  default = {
    "Organizations"     = "PwP0-CCC-E&O"
    "DeploymentVersion" = "2018-12-14-01"
    "Classification"    = "Unclassified"
    "Enviroment"        = "Sandbox"
    "CostCenter"        = "PwP0-EA"
    "Owner"             = "cloudteam@tpsgc-pwgsc.gc.ca"
  }
}

variable "keyvault" {
  default = {
    name                = "PwS3-Infra-KV-simc2atbrf"
    resource_group_name = "PwS3-Infra-Keyvault-RG"
  }
}

variable "FW-A" {
  default = {
    nic1 = {
      private_ip_address = "100.96.112.4"
    }
    nic2 = {
      private_ip_address = "100.96.116.5"
    }
    nic3 = {
      private_ip_address = "100.96.116.36"
    }
    nic4 = {
      private_ip_address = "100.96.116.68"
    }
    vm_size     = "Standard_F4"
    custom_data = "fwconfig/coreA-lic.conf"
  }
}

variable "FW-B" {
  default = {
    nic1 = {
      private_ip_address = "100.96.112.5"
    }
    nic2 = {
      private_ip_address = "100.96.116.6"
    }
    nic3 = {
      private_ip_address = "100.96.116.37"
    }
    nic4 = {
      private_ip_address = "100.96.116.69"
    }
    vm_size     = "Standard_F4"
    custom_data = "fwconfig/coreB-lic.conf"
  }
}
