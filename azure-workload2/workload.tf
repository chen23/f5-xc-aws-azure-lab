# Create public IPs
resource "azurerm_public_ip" "workload" {
  name                = "workload_pip"
  resource_group_name = var.resourceGroup
  location            = var.azureRegion2
  allocation_method   = "Dynamic"
}

# Create NIC
resource "azurerm_network_interface" "workload" {
  name                = "workload-nic"
  resource_group_name = var.resourceGroup
  location            = var.azureRegion2

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.workloadSubnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.workload.id
  }
}
# Create virtual machine
resource "azurerm_linux_virtual_machine" "workload" {
  name                = "workload"
  resource_group_name = var.resourceGroup
  location            = var.azureRegion2
  size                = "Standard_DS1_v2"

  network_interface_ids = [azurerm_network_interface.workload.id]

  os_disk {
    name                 = "workload"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "workload"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  custom_data = "IyEvYmluL2Jhc2gKc2xlZXAgMzAKc25hcCBpbnN0YWxsIGRvY2tlcgpzeXN0ZW1jdGwgZW5hYmxlIHNuYXAuZG9ja2VyLmRvY2tlcmQKc3lzdGVtY3RsIHN0YXJ0IHNuYXAuZG9ja2VyLmRvY2tlcmQKc2xlZXAgMzAKZG9ja2VyIHJ1biAtZCAtLW5ldD1ob3N0IC0tcmVzdGFydD1hbHdheXMgXAotZSBGNURFTU9fQVBQPXRleHQgXAotZSBGNURFTU9fTk9ERU5BTUU9J0F6dXJlIEVudmlyb25tZW50JyBcCi1lIEY1REVNT19DT0xPUj1mZmQ3MzQgXAotZSBGNURFTU9fTk9ERU5BTUVfU1NMPSdBenVyZSBFbnZpcm9ubWVudCAoQmFja2VuZCBBcHApJyBcCi1lIEY1REVNT19DT0xPUl9TU0w9YTBiZjM3IFwKLWUgRjVERU1PX0JSQU5EPXZvbHRlcnJhIFwKcHVibGljLmVjci5hd3MveTluMnk1cTUvZjUtZGVtby1odHRwZDpvcGVuc2hpZnQ="
  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }
}