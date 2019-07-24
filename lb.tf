resource azurerm_lb_backend_address_pool FW-ExternalLoadBalancer__FWpublicLBBE {
  name                = "${var.envprefix}FWpublicLBBE"
  resource_group_name = "${local.rgname.fortigate}"
  loadbalancer_id     = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
}

resource azurerm_lb_backend_address_pool FW-InternalLoadBalancer__FW-ILB-CoreToSpokes-BackEnd {
  name                = "${var.envprefix}FW-ILB-CoreToSpokes-BackEnd"
  resource_group_name = "${local.rgname.fortigate}"
  loadbalancer_id     = "${azurerm_lb.FW-InternalLoadBalancer.id}"
}

resource azurerm_lb_probe FW-ExternalLoadBalancer__lbprobe {
  name                = "lbprobe"
  resource_group_name = "${local.rgname.fortigate}"
  loadbalancer_id     = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
  protocol            = "Tcp"
  port                = "8008"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

resource azurerm_lb_probe FW-InternalLoadBalancer__lbprobe {
  name                = "lbprobe"
  resource_group_name = "${local.rgname.fortigate}"
  loadbalancer_id     = "${azurerm_lb.FW-InternalLoadBalancer.id}"
  protocol            = "Tcp"
  port                = "8008"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

resource azurerm_lb_rule FW-ExternalLoadBalancer__jumpboxRDP {
  name                           = "jumpboxRDP"
  resource_group_name            = "${local.rgname.fortigate}"
  loadbalancer_id                = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
  frontend_ip_configuration_name = "${var.envprefix}FWpublicLBFE"
  protocol                       = "Tcp"
  frontend_port                  = "33890"
  backend_port                   = "33890"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
  probe_id                       = "${azurerm_lb_probe.FW-ExternalLoadBalancer__lbprobe.id}"
  enable_floating_ip             = false
  idle_timeout_in_minutes        = "15"
  load_distribution              = "Default"
}

resource azurerm_lb_rule FW-InternalLoadBalancer__lbruleFE2all {
  name                           = "lbruleFE2all"
  resource_group_name            = "${local.rgname.fortigate}"
  loadbalancer_id                = "${azurerm_lb.FW-InternalLoadBalancer.id}"
  frontend_ip_configuration_name = "${var.envprefix}FW-ILB-CoreToSpokes-FrontEnd"
  protocol                       = "All"
  frontend_port                  = "0"
  backend_port                   = "0"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.FW-InternalLoadBalancer__FW-ILB-CoreToSpokes-BackEnd.id}"
  probe_id                       = "${azurerm_lb_probe.FW-InternalLoadBalancer__lbprobe.id}"
  enable_floating_ip             = true
  idle_timeout_in_minutes        = "15"
  load_distribution              = "Default"
}

resource azurerm_lb FW-ExternalLoadBalancer {
  name                = "${var.envprefix}FW-ExternalLoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "${var.envprefix}FWpublicLBFE"
    public_ip_address_id = "${azurerm_public_ip.FW-ELB-PubIP.id}"
  }
  tags = "${var.tags}"
}

resource azurerm_lb FW-InternalLoadBalancer {
  name                = "${var.envprefix}FW-InternalLoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${local.rgname.fortigate}"
  sku                 = "Standard"
  frontend_ip_configuration {
    name               = "${var.envprefix}FW-ILB-CoreToSpokes-FrontEnd"
    subnet_id          = "${data.azurerm_subnet.CoreToSpokes.id}"
    private_ip_address = "100.96.116.4"
    private_ip_address_allocation = "Static"
  }
  tags = "${var.tags}"
}
