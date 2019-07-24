data "azurerm_key_vault" "keyvaultsecrets" {
  name = "${var.keyvault.name}"
  resource_group_name = "${var.keyvault.resource_group_name}"
}

data "azurerm_key_vault_secret" "fwpasswordsecret" {
  name         = "${var.secretPasswordName}"
  key_vault_id = "${data.azurerm_key_vault.keyvaultsecrets.id}"
}

data "azurerm_subnet" "Outside" {
  name                 = "${local.fwsubnets.outside}"
  virtual_network_name = "${local.vnetname.netcore}"
  resource_group_name  = "${local.rgname.netcore}"
}

data "azurerm_subnet" "CoreToSpokes" {
  name                 = "${local.fwsubnets.inside}"
  virtual_network_name = "${local.vnetname.netcore}"
  resource_group_name  = "${local.rgname.netcore}"
}

data "azurerm_subnet" "HASync" {
  name                 = "${local.fwsubnets.ha}"
  virtual_network_name = "${local.vnetname.netcore}"
  resource_group_name  = "${local.rgname.netcore}"
}

data "azurerm_subnet" "Management" {
  name                 = "${local.fwsubnets.mgmt}"
  virtual_network_name = "${local.vnetname.netcore}"
  resource_group_name  = "${local.rgname.netcore}"
}

