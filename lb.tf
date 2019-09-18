resource azurerm_lb_backend_address_pool FW-ExternalLoadBalancer__FWpublicLBBE {
  name                = "${var.name}FWpublicLBBE"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
}

resource azurerm_lb_backend_address_pool FW-InternalLoadBalancer__FW-ILB-Inside-BackEnd {
  name                = "${var.name}-ILB-Inside-BackEnd"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.FW-InternalLoadBalancer.id}"
}

resource azurerm_lb_probe FW-ExternalLoadBalancer__lbprobe {
  name                = "lbprobe"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
  protocol            = "Tcp"
  port                = "8008"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

resource azurerm_lb_probe FW-InternalLoadBalancer__lbprobe {
  name                = "lbprobe"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.FW-InternalLoadBalancer.id}"
  protocol            = "Tcp"
  port                = "8008"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

resource azurerm_lb_rule FW-InternalLoadBalancer__lbruleFE2all {
  name                           = "lbruleFE2all"
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${azurerm_lb.FW-InternalLoadBalancer.id}"
  frontend_ip_configuration_name = "${var.name}-ILB-Inside-FrontEnd"
  protocol                       = "All"
  frontend_port                  = "0"
  backend_port                   = "0"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-Inside-BackEnd.id}"
  probe_id                       = "${azurerm_lb_probe.FW-InternalLoadBalancer__lbprobe.id}"
  enable_floating_ip             = true
  idle_timeout_in_minutes        = "15"
  load_distribution              = "Default"
}

resource azurerm_lb FW-ExternalLoadBalancer {
  name                = "${var.name}-External-lb"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "${var.name}-publicLBFE"
    public_ip_address_id = "${azurerm_public_ip.FW-ELB-PubIP.id}"
  }
  tags = "${var.tags}"
}

resource azurerm_lb FW-InternalLoadBalancer {
  name                = "${var.name}-Internal-lb"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  frontend_ip_configuration {
    name               = "${var.name}-ILB-Inside-FrontEnd"
    subnet_id          = "${data.azurerm_subnet.Inside.id}"
    private_ip_address = var.lbfeip
    private_ip_address_allocation = "Static"
  }
  tags = "${var.tags}"
}
