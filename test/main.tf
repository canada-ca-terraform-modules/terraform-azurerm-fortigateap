terraform {
  required_version = ">= 0.12.1"
}
provider "azurerm" {
  version = ">= 1.32.0"
}

locals {
  template_name = "fortigateap"
}

data "azurerm_client_config" "current" {}

module "test-fortigateap" {
  source = "../."

  name                    = "TST-fw-core"
  vm_size                 = "Standard_F4"
  resource_group_name     = "${azurerm_resource_group.test-RG.name}"
  admin_username          = "azureadmin"
  admin_password          = "Canada123!"
  vnet_name = "${azurerm_virtual_network.test-VNET.name}"
  vnet_resource_group_name = "${azurerm_resource_group.test-RG.name}"
  fw01_custom_data = "fwconfig/fw01.conf"
  fw02_custom_data = "fwconfig/fw02.conf"
  outside_subnet_name = azurerm_subnet.outside.name
  inside_subnet_name = azurerm_subnet.inside.name
  mgmt_subnet_name = azurerm_subnet.management.name
  ha_subnet_name = azurerm_subnet.ha.name
  fw01_nic1_private_ip_address = "10.10.10.4"
  fw01_nic2_private_ip_address = "10.10.10.37"
  fw01_nic3_private_ip_address = "10.10.10.100"
  fw01_nic4_private_ip_address = "10.10.10.68"
  fw02_nic1_private_ip_address = "10.10.10.5"
  fw02_nic2_private_ip_address = "10.10.10.38"
  fw02_nic3_private_ip_address = "10.10.10.101"
  fw02_nic4_private_ip_address = "10.10.10.69"
  lbfeip  = "10.10.10.36"
  tags = var.tags
}
