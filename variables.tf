variable "location" {
  description = "Location of the network"
  default     = "canadacentral"
}

variable "tags" {
}

variable "name" {
  
}
variable "vm_size" {
  default = "Standard_F4"
}
variable "admin_username" {
  description = "Name of the VM admin account"
}

variable "admin_password" {
  description = "Name of the VM admin account"
}
variable "resource_group_name" {
  
}
variable "vnet_name" {
  
}
variable "vnet_resource_group_name" {
  
}
variable "fw01_custom_data" {
  
}
variable "fw02_custom_data" {
  
}
variable "outside_subnet_name" {
  
}
variable "inside_subnet_name" {
  
}
variable "mgmt_subnet_name" {
  
}
variable "ha_subnet_name" {
  
}

variable "fw01_nic1_private_ip_address" {
  
}

variable "fw01_nic2_private_ip_address" {
  
}
variable "fw01_nic3_private_ip_address" {
  
}
variable "fw01_nic4_private_ip_address" {
  
}

variable "fw02_nic1_private_ip_address" {
  
}

variable "fw02_nic2_private_ip_address" {
  
}
variable "fw02_nic3_private_ip_address" {
  
}
variable "fw02_nic4_private_ip_address" {
  
}

variable "storage_image_reference" {
  description = "description"
  default = {
      publisher = "fortinet"
      offer     = "fortinet_fortigate-vm_v5"
      sku       = "fortinet_fg-vm"
      version   = "latest"
    }
}

variable "plan" {
  description = "description"
  default = {
    name      = "fortinet_fg-vm"
    publisher = "fortinet"
    product   = "fortinet_fortigate-vm_v5"
  }
}

variable "lbfeip" {
  description = "Static IP for the internal LB"
}
