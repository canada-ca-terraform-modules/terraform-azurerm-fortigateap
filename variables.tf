variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "envprefix" {
  description = "Prefix for the environment"
  default     = "Demo"
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

variable "firewall" {
  default = {
    fwprefix                     = "FW"
    vm_size                      = "Standard_F4"
    vnet_name                    = "Core-NetCore-VNET"
    fortigate_resourcegroup_name = "Core-FWCore-RG"
    keyvault_resourcegroup_name  = "Core-Keyvault-RG"
    vnet_resourcegroup_name      = "Core-NetCore-RG"
    fwa_custom_data              = "fwconfig/coreA-lic.conf"
    fwb_custom_data              = "fwconfig/coreB-lic.conf"
    outside_subnet_name          = "Outside"
    inside_subnet_name           = "CoreToSpokes"
    mgmt_subnet_name             = "Management"
    ha_subnet_name               = "HASync"
    fwa_nic1_private_ip_address  = "100.96.112.4"
    fwa_nic2_private_ip_address  = "100.96.116.5"
    fwa_nic3_private_ip_address  = "100.96.116.36"
    fwa_nic4_private_ip_address  = "100.96.116.68"
    fwb_nic1_private_ip_address  = "100.96.112.5"
    fwb_nic2_private_ip_address  = "100.96.116.6"
    fwb_nic3_private_ip_address  = "100.96.116.37"
    fwb_nic4_private_ip_address  = "100.96.116.69"
    storage_image_reference = {
      publisher = "fortinet"
      offer     = "fortinet_fortigate-vm_v5"
      sku       = "fortinet_fg-vm"
      version   = "latest"
    }
    plan = {
      name      = "fortinet_fg-vm"
      publisher = "fortinet"
      product   = "fortinet_fortigate-vm_v5"
    }
  }
}
