output workload_pip {
  value = azurerm_linux_virtual_machine.workload.public_ip_address
}
output workload_private_ip {
  value = azurerm_linux_virtual_machine.workload.private_ip_address
}