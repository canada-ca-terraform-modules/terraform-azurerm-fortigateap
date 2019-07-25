output "loadbalancer_id" {
  value = "${azurerm_lb.FW-ExternalLoadBalancer.id}"
}

output "backend_address_pool_id" {
  value = "${azurerm_lb_backend_address_pool.FW-ExternalLoadBalancer__FWpublicLBBE.id}"
}

output "probe_id" {
  value = "${azurerm_lb_probe.FW-ExternalLoadBalancer__lbprobe.id}"
}