resource azurerm_availability_set availabilityset {
  name                         = "${var.name}-as"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "2"
  managed                      = "true"
  tags                         = "${var.tags}"
}

resource azurerm_network_security_group NSG {
  name                = "${var.name}-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
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


resource azurerm_network_interface FW-01-nic1 {
  name                          = "${var.name}-01-nic1"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Outside.id}"
    private_ip_address                      = "${var.fw01_nic1_private_ip_address}"
    private_ip_address_allocation           = "Static"
    public_ip_address_id                    = "${azurerm_public_ip.FW-01-EXT-PubIP.id}"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-01-nic1-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-01-nic1.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
}

resource azurerm_network_interface FW-01-nic2 {
  name                          = "${var.name}-01-nic2"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Inside.id}"
    private_ip_address                      = "${var.fw01_nic2_private_ip_address}"
    private_ip_address_allocation           = "Static"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-01-nic2-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-01-nic2.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-Inside-BackEnd.id}"
}

resource azurerm_network_interface FW-01-nic3 {
  name                          = "${var.name}-01-nic3"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.fw01_nic3_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-01-nic4 {
  name                          = "${var.name}-01-nic4"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.fw01_nic4_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-02-nic1 {
  name                          = "${var.name}-02-nic1"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Outside.id}"
    private_ip_address                      = "${var.fw02_nic1_private_ip_address}"
    private_ip_address_allocation           = "Static"
    public_ip_address_id                    = "${azurerm_public_ip.FW-02-EXT-PubIP.id}"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-02-nic1-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-02-nic1.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
}

resource azurerm_network_interface FW-02-nic2 {
  name                          = "${var.name}-02-nic2"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                                    = "ipconfig1"
    subnet_id                               = "${data.azurerm_subnet.Inside.id}"
    private_ip_address                      = "${var.fw02_nic2_private_ip_address}"
    private_ip_address_allocation           = "Static"
    primary                                 = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "FW-02-nic2-LBBE" {
  network_interface_id    = "${azurerm_network_interface.FW-02-nic2.id}"
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-Inside-BackEnd.id}"
}

resource azurerm_network_interface FW-02-nic3 {
  name                          = "${var.name}-02-nic3"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.HASync.id}"
    private_ip_address            = "${var.fw02_nic3_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_network_interface FW-02-nic4 {
  name                          = "${var.name}-02-nic4"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  enable_ip_forwarding          = true
  enable_accelerated_networking = false
  network_security_group_id     = "${azurerm_network_security_group.NSG.id}"
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${data.azurerm_subnet.Management.id}"
    private_ip_address            = "${var.fw02_nic4_private_ip_address}"
    private_ip_address_allocation = "Static"
    primary                       = true
  }
}

resource azurerm_public_ip FW-01-EXT-PubIP {
  name                = "${var.name}-01-pip1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-01-MGMT-PubIP {
  name                = "${var.name}-01-pip2"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-02-EXT-PubIP {
  name                = "${var.name}-02-pip1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-02-MGMT-PubIP {
  name                = "${var.name}-02-pip2"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_public_ip FW-ELB-PubIP {
  name                = "${var.name}-ELB-pip1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = "${var.tags}"
}

resource azurerm_virtual_machine FW-01 {
  name                = "${var.name}-01-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.vm_size}"
  network_interface_ids = [
    "${azurerm_network_interface.FW-01-nic1.id}",
    "${azurerm_network_interface.FW-01-nic2.id}",
    "${azurerm_network_interface.FW-01-nic3.id}",
  "${azurerm_network_interface.FW-01-nic4.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.FW-01-nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${var.name}-01"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data    = "${file("${var.fw01_custom_data}")}"
  }
  storage_image_reference {
    publisher = "${var.storage_image_reference.publisher}"
    offer     = "${var.storage_image_reference.offer}"
    sku       = "${var.storage_image_reference.sku}"
    version   = "${var.storage_image_reference.version}"
  }
  plan {
    name      = "${var.plan.name}"
    publisher = "${var.plan.publisher}"
    product   = "${var.plan.product}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name          = "${var.name}-01-osdisk1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${var.name}-01-datadisk1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}

resource azurerm_virtual_machine FW-02 {
  name                = "${var.name}-02-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  availability_set_id = "${azurerm_availability_set.availabilityset.id}"
  vm_size             = "${var.vm_size}"
  network_interface_ids = [
    "${azurerm_network_interface.FW-02-nic1.id}",
    "${azurerm_network_interface.FW-02-nic2.id}",
    "${azurerm_network_interface.FW-02-nic3.id}",
  "${azurerm_network_interface.FW-02-nic4.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.FW-02-nic1.id}"
  delete_data_disks_on_termination = "true"
  delete_os_disk_on_termination    = "true"
  os_profile {
    computer_name  = "${var.name}-02"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data    = "${file("${var.fw02_custom_data}")}"
  }
  storage_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }
  plan {
    name      = var.plan.name
    publisher = var.plan.publisher
    product   = var.plan.product
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name          = "${var.name}-02-osdisk1"
    caching       = "ReadWrite"
    create_option = "FromImage"
    os_type       = "Linux"
    disk_size_gb  = "2"
  }
  storage_data_disk {
    name          = "${var.name}-02-datadisk1"
    lun           = 0
    caching       = "None"
    create_option = "Empty"
    disk_size_gb  = "30"
  }
  tags = "${var.tags}"
}
