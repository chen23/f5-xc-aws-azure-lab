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
  paths = ["../base-aws-network2","../tgw-site2"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network2"
  mock_outputs = {
    spokeExternalSubnets= {
      "az1" = {
        "id" = "1"
      }
    }
    spokeWorkloadSubnets = {
      "az1" = {
        "id" = "1"
      }
    }
    spokeSecurityGroup = {
      "az1" = {
        "id" = "1"
      }
    }
  }
}

inputs = {
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
}
