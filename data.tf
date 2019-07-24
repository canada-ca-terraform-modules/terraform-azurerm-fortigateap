data "azurerm_key_vault" "keyvaultsecrets" {
  name = "${var.keyvault.name}"
  resource_group_name = "${var.keyvault.resource_group_name}"
}

data "azurerm_key_vault_secret" "fwpasswordsecret" {
  name         = "${var.firewall.secretPasswordName}"
  key_vault_id = "${data.azurerm_key_vault.keyvaultsecrets.id}"
}

data "azurerm_subnet" "Outside" {
  name                 = "${var.firewall.outside_subnet_name}"
  virtual_network_name = "${var.firewall.vnet_name}"
  resource_group_name  = "${var.firewall.vnet_resourcegroup_name}"
}

data "azurerm_subnet" "CoreToSpokes" {
  name                 = "${var.firewall.inside_subnet_name}"
  virtual_network_name = "${var.firewall.vnet_name}"
  resource_group_name  = "${var.firewall.vnet_resourcegroup_name}"
}

data "azurerm_subnet" "HASync" {
  name                 = "${var.firewall.ha_subnet_name}"
  virtual_network_name = "${var.firewall.vnet_name}"
  resource_group_name  = "${var.firewall.vnet_resourcegroup_name}"
}

data "azurerm_subnet" "Management" {
  name                 = "${var.firewall.mgmt_subnet_name}"
  virtual_network_name = "${var.firewall.vnet_name}"
  resource_group_name  = "${var.firewall.vnet_resourcegroup_name}"
}

