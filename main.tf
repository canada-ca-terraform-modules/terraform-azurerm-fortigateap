resource azurerm_availability_set availabilityset {
  name                         = "${var.firewall.fwprefix}-AvailabilitySet"
  location                     = "${var.location}"
  resource_group_name          = "${var.firewall.fortigate_resourcegroup_name}"
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "2"
  managed                      = "true"
  tags                         = "${var.tags}"
}

resource azurerm_network_security_group NSG {
  name                = "${var.firewall.fwprefix}-NSG"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  security_rule {
    name                       = "AllowAllInbound"
    description                = "Allow all in"
    access                     = "Allow"
    priority                   = "100"
    protocol                   = "*"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAllOutbound"
    description                = "Allow all out"
    access                     = "Allow"
    priority                   = "105"
    protocol                   = "*"
    direction                  = "Outbound"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  tags = "${var.tags}"
}


resource azurerm_network_interface FW-A-Nic1 {
  name                          = "${var.firewall.fwprefix}-A-Nic1"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Outside.id}"
    private_ip_address                      = "${var.firewall.fwa_nic1_private_ip_address}"
    private_ip_address_allocation           = "Static"
    public_ip_address_id                    = "${azurerm_public_ip.FW-A-EXT-PubIP.id}"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-A-Nic1-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-A-Nic1.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
}

resource azurerm_network_interface FW-A-Nic2 {
  name                          = "${var.firewall.fwprefix}-A-Nic2"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.CoreToSpokes.id}"
    private_ip_address                      = "${var.firewall.fwa_nic2_private_ip_address}"
    private_ip_address_allocation           = "Static"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-A-Nic2-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-A-Nic2.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-CoreToSpokes-BackEnd.id}"
}

resource azurerm_network_interface FW-A-Nic3 {
  name                          = "${var.firewall.fwprefix}-A-Nic3"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.firewall.fwa_nic3_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-A-Nic4 {
  name                          = "${var.firewall.fwprefix}-A-Nic4"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.firewall.fwa_nic4_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic1 {
  name                          = "${var.firewall.fwprefix}-B-Nic1"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Outside.id}"
    private_ip_address                      = "${var.firewall.fwb_nic1_private_ip_address}"
    private_ip_address_allocation           = "Static"
    public_ip_address_id                    = "${azurerm_public_ip.FW-B-EXT-PubIP.id}"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-B-Nic1-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-B-Nic1.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
}

resource azurerm_network_interface FW-B-Nic2 {
  name                          = "${var.firewall.fwprefix}-B-Nic2"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.CoreToSpokes.id}"
    private_ip_address                      = "${var.firewall.fwb_nic2_private_ip_address}"
    private_ip_address_allocation           = "Static"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-B-Nic2-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-B-Nic2.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-CoreToSpokes-BackEnd.id}"
}

resource azurerm_network_interface FW-B-Nic3 {
  name                          = "${var.firewall.fwprefix}-B-Nic3"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.firewall.fwb_nic3_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic4 {
  name                          = "${var.firewall.fwprefix}-B-Nic4"
  location                      = "${var.location}"
  resource_group_name           = "${var.firewall.fortigate_resourcegroup_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.firewall.fwb_nic4_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_public_ip FW-A-EXT-PubIP {
  name                = "${var.firewall.fwprefix}-A-EXT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-A-MGMT-PubIP {
  name                = "${var.firewall.fwprefix}-A-MGMT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-B-EXT-PubIP {
  name                = "${var.firewall.fwprefix}-B-EXT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-B-MGMT-PubIP {
  name                = "${var.firewall.fwprefix}-B-MGMT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-ELB-PubIP {
  name                = "${var.firewall.fwprefix}-ELB-PubIP"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_virtual_machine FW-A {
  name                = "${var.firewall.fwprefix}-A"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.firewall.vm_size}"
  network_interface_ids = [
    "${azurerm_network_interface.FW-A-Nic1.id}",
    "${azurerm_network_interface.FW-A-Nic2.id}",
    "${azurerm_network_interface.FW-A-Nic3.id}",
  "${azurerm_network_interface.FW-A-Nic4.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.FW-A-Nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${var.firewall.fwprefix}-A"
    admin_username = "${var.firewall.adminName}"
    admin_password = "${data.azurerm_key_vault_secret.fwpasswordsecret.value}"
    custom_data    = "${file("${var.firewall.fwa_custom_data}")}"
  }
  storage_image_reference {
    publisher = "${var.firewall.storage_image_reference.publisher}"
    offer     = "${var.firewall.storage_image_reference.offer}"
    sku       = "${var.firewall.storage_image_reference.sku}"
    version   = "${var.firewall.storage_image_reference.version}"
  }
  plan {
    name      = "${var.firewall.plan.name}"
    publisher = "${var.firewall.plan.publisher}"
    product   = "${var.firewall.plan.product}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name          = "${var.firewall.fwprefix}-A_OsDisk_1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${var.firewall.fwprefix}-A_DataDisk_1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}

resource azurerm_virtual_machine FW-B {
  name                = "${var.firewall.fwprefix}-B"
  location            = "${var.location}"
  resource_group_name = "${var.firewall.fortigate_resourcegroup_name}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.firewall.vm_size}"
  network_interface_ids = [
    "${azurerm_network_interface.FW-B-Nic1.id}",
    "${azurerm_network_interface.FW-B-Nic2.id}",
    "${azurerm_network_interface.FW-B-Nic3.id}",
  "${azurerm_network_interface.FW-B-Nic4.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.FW-B-Nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${var.firewall.fwprefix}-B"
    admin_username = "${var.firewall.adminName}"
    admin_password = "${data.azurerm_key_vault_secret.fwpasswordsecret.value}"
    custom_data    = "${file("${var.firewall.fwb_custom_data}")}"
  }
  storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       = "fortinet_fg-vm"
    version   = "latest"
  }
  plan {
    name      = "fortinet_fg-vm"
    publisher = "fortinet"
    product   = "fortinet_fortigate-vm_v5"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name          = "${var.firewall.fwprefix}-B_OsDisk_1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${var.firewall.fwprefix}-B_DataDisk_1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}
