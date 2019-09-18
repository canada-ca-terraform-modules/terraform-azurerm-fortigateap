# Terraform AzureRM Fortigate Active Passive

## Introduction

This Terraform module deploys an Active/Passive Fortigate HA Firewall with internal and external fronting loadbalancers.

## Security Controls

The following security controls can be met through configuration of this template:

* AC-1, AC-10, AC-11, AC-11(1), AC-12, AC-14, AC-16, AC-17, AC-18, AC-18(4), AC-2 , AC-2(5), AC-20(1) , AC-20(3), AC-20(4), AC-24(1), AC-24(11), AC-3, AC-3 , AC-3(1), AC-3(3), AC-3(9), AC-4, AC-4(14), AC-6, AC-6, AC-6(1), AC-6(10), AC-6(11), AC-7, AC-8, AC-8, AC-9, AC-9(1), AI-16, AU-2, AU-3, AU-3(1), AU-3(2), AU-4, AU-5, AU-5(3), AU-8(1), AU-9, CM-10, CM-11(2), CM-2(2), CM-2(4), CM-3, CM-3(1), CM-3(6), CM-5(1), CM-6, CM-6, CM-7, CM-7, IA-1, IA-2, IA-3, IA-4(1), IA-4(4), IA-5, IA-5, IA-5(1), IA-5(13), IA-5(1c), IA-5(6), IA-5(7), IA-9, SC-10, SC-13, SC-15, SC-18(4), SC-2, SC-2, SC-23, SC-28, SC-30(5), SC-5, SC-7, SC-7(10), SC-7(16), SC-7(8), SC-8, SC-8(1), SC-8(4), SI-14, SI-2(1), SI-3

## Dependancies

* [Resource Groups](https://github.com/canada-ca-azure-templates/resourcegroups/blob/master/readme.md)
* [Keyvault](https://github.com/canada-ca-azure-templates/keyvaults/blob/master/readme.md)
* [VNET-Subnet](https://github.com/canada-ca-azure-templates/vnet-subnet/blob/master/readme.md)

## Usage

```terraform
module "fortigateap" {
  #source = "github.com/canada-ca-terraform-modules/terraform-azurerm-fortigateap?ref=20190725.1"
  source = "./terraform-azurerm-fortigateap"

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
}
```

## Parameter Values

TO BE DOCUMENTED

### Tag variable

| Name     | Type   | Required | Value      |
| -------- | ------ | -------- | ---------- |
| tagname1 | string | No       | tag1 value |
| ...      | ...    | ...      | ...        |
| tagnameX | string | No       | tagX value |

## History

| Date     | Release    | Change                                                                                                             |
| -------- | ---------- | ------------------------------------------------------------------------------------------------------------------ |
| 20190725 | 20190725.1 | Fix missing backend LB association and add support for lbrules definition using output from module as demonstrated |
| 20190724 | 20190724.1 | 1st deploy                                                                                                         |
