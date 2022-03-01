output projectPrefix {
  value = var.projectPrefix
}
output azureRegion {
  value = var.azureRegion
}
output resourceGroup {
  value = "${var.projectPrefix}-f5-xc"
}
output hubVnetName {
  value = azurerm_virtual_network.f5-xc-hub.name
}