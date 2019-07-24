resource azurerm_availability_set availabilityset {
  name                         = "${local.fwprefix}-AvailabilitySet"
  location                     = "${var.location}"
  resource_group_name          = "${local.rgname.fortigate}"
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "2"
  managed                      = "true"
  tags                         = "${var.tags}"
}

resource azurerm_network_security_group NSG {
  name                = "${local.fwprefix}-NSG"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
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
  name                          = "${local.fwprefix}-A-Nic1"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Outside.id}"
    private_ip_address            = "${var.FW-A.nic1.private_ip_address}"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = "${azurerm_public_ip.FW-A-EXT-PubIP.id}"
    primary                       = true
  }
}

resource azurerm_network_interface FW-A-Nic2 {
  name                          = "${local.fwprefix}-A-Nic2"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.CoreToSpokes.id}"
    private_ip_address            = "${var.FW-A.nic2.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-A-Nic3 {
  name                          = "${local.fwprefix}-A-Nic3"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.FW-A.nic3.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-A-Nic4 {
  name                          = "${local.fwprefix}-A-Nic4"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.FW-A.nic4.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic1 {
  name                          = "${local.fwprefix}-B-Nic1"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Outside.id}"
    private_ip_address            = "${var.FW-B.nic1.private_ip_address}"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = "${azurerm_public_ip.FW-B-EXT-PubIP.id}"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic2 {
  name                          = "${local.fwprefix}-B-Nic2"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.CoreToSpokes.id}"
    private_ip_address            = "${var.FW-B.nic2.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic3 {
  name                          = "${local.fwprefix}-B-Nic3"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.FW-B.nic3.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-B-Nic4 {
  name                          = "${local.fwprefix}-B-Nic4"
  location                      = "${var.location}"
  resource_group_name           = "${local.rgname.fortigate}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.FW-B.nic4.private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_public_ip FW-A-EXT-PubIP {
  name                = "${local.fwprefix}-A-EXT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-A-MGMT-PubIP {
  name                = "${local.fwprefix}-A-MGMT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-B-EXT-PubIP {
  name                = "${local.fwprefix}-B-EXT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-B-MGMT-PubIP {
  name                = "${local.fwprefix}-B-MGMT-PubIP"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-ELB-PubIP {
  name                = "${local.fwprefix}-ELB-PubIP"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_virtual_machine FW-A {
  name                = "${local.fwprefix}-A"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.FW-A.vm_size}"
  network_interface_ids = [
  "${azurerm_network_interface.FW-A-Nic1.id}", 
  "${azurerm_network_interface.FW-A-Nic2.id}", 
  "${azurerm_network_interface.FW-A-Nic3.id}", 
  "${azurerm_network_interface.FW-A-Nic4.id}" ]
  primary_network_interface_id     = "${azurerm_network_interface.FW-A-Nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${local.fwprefix}-A"
    admin_username = "fwadmin"
    admin_password = "${data.azurerm_key_vault_secret.fwpasswordsecret.value}"
    custom_data    = "${file("${var.FW-A.custom_data}")}"
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
    name          = "${local.fwprefix}-A_OsDisk_1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${local.fwprefix}-A_DataDisk_1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}

resource azurerm_virtual_machine FW-B {
  name                = "${local.fwprefix}-B"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.FW-A.vm_size}"
  network_interface_ids = [
    "${azurerm_network_interface.FW-B-Nic1.id}",
    "${azurerm_network_interface.FW-B-Nic2.id}",
    "${azurerm_network_interface.FW-B-Nic3.id}",
    "${azurerm_network_interface.FW-B-Nic4.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.FW-B-Nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${local.fwprefix}-B"
    admin_username = "fwadmin"
    admin_password = "${data.azurerm_key_vault_secret.fwpasswordsecret.value}"
    custom_data    = "${file("${var.FW-B.custom_data}")}"
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
    name          = "${local.fwprefix}-B_OsDisk_1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${local.fwprefix}-B_DataDisk_1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}
