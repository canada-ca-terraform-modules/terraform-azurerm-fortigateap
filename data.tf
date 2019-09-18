data "azurerm_subnet" "Outside" {
  name                 = "${var.outside_subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.vnet_resource_group_name}"
}

data "azurerm_subnet" "Inside" {
  name                 = "${var.inside_subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.vnet_resource_group_name}"
}

data "azurerm_subnet" "HASync" {
  name                 = "${var.ha_subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.vnet_resource_group_name}"
}

data "azurerm_subnet" "Management" {
  name                 = "${var.mgmt_subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.vnet_resource_group_name}"
}