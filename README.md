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
terraform {
  required_version = ">= 0.12.1"
}

provider "azurerm" {
  version         = "= 1.31.0"
  subscription_id = "2de839a0-37f9-4163-a32a-e1bdbsdfgb7e"
}

data "azurerm_client_config" "current" {}

variable "envprefix" {
  description = "Prefix for the environment"
  default     = "Demo"
}

module "fortigateap" {
  source = "./module"

  location  = "canadacentral"
  envprefix = "Demo"
  
  keyvault = {
    name                = "${var.envprefix}-Core-KV-${substr(sha1("${data.azurerm_client_config.current.subscription_id}${var.envprefix}-Core-Keyvault-RG"),0,8)}"
    resource_group_name = "${var.envprefix}-Core-Keyvault-RG"
  }

  secretPasswordName = "fwpassword"
  
  FW-A = {
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
  FW-B = {
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

| Date     | Release | Change     |
| -------- | ------- | ---------- |
| 20190724 |         | 1st deploy |
