include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../base-azure-network"]
}

dependency "infrastructure" {
  config_path = "../base-azure-network"
  mock_outputs = {
    resourceGroup = "foo"
    hubVnetName = ""
  }
}

inputs = {
    resourceGroup = dependency.infrastructure.outputs.resourceGroup
    hubVnetName   = dependency.infrastructure.outputs.hubVnetName
}

