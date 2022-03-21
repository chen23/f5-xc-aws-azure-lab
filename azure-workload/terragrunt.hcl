include "root" {
  path = find_in_parent_folders()
}

terraform {

    before_hook "pre-check" {
        commands = ["apply","plan"]
        execute  = ["./pre-check.sh"]
    }

}


dependencies {
  paths = ["../base-azure-network"]
}

dependency "infrastructure" {
  config_path = "../base-azure-network"
}

inputs = {
    resourceGroup = dependency.infrastructure.outputs.resourceGroup
    hubVnetName   = dependency.infrastructure.outputs.hubVnetName
    workloadSubnet = dependency.infrastructure.outputs.workloadSubnet
}

