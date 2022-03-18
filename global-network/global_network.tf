resource "volterra_virtual_network" "global-network" {
  name        = format("%s-global-network", var.projectPrefix)
  namespace = "system"
  global_network = true
}
