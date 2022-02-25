include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../base-aws-network","../tgw-site"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
}

inputs = {
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
}