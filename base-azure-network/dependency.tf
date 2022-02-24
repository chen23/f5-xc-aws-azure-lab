data "template_file" "azure_tfvars" {
  template = file("../azure-site/terraform.tfvars.json.example")
  vars = {
    projectPrefix   = var.projectPrefix
    azureRegion       = var.azureRegion
    resourceGroup     = "${var.projectPrefix}-f5-xc"
    hubVnetName       = azurerm_virtual_network.f5-xc-hub.name
  }
}

resource "local_file" "azure_tfvars" {
  content  = data.template_file.azure_tfvars.rendered
  filename = "../azure-site/terraform.tfvars.json"
}