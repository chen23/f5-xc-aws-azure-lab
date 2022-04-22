include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../base-azure-network2"]
}

dependency "infrastructure" {
  config_path = "../base-azure-network2"
  mock_outputs = {
    resourceGroup = "foo"
    hubVnetName = ""
  }
}

inputs = {
    resourceGroup = dependency.infrastructure.outputs.resourceGroup
    hubVnetName   = dependency.infrastructure.outputs.hubVnetName
}

