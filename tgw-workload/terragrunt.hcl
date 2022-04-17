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
  paths = ["../base-aws-network","../tgw-site"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
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
    spoke2ExternalSubnets= {
      "az1" = {
        "id" = "1"
      }
    }
    spoke2WorkloadSubnets = {
      "az1" = {
        "id" = "1"
      }
    }
    spoke2SecurityGroup = {
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
    spoke2ExternalSubnets = dependency.infrastructure.outputs.spoke2ExternalSubnets
    spoke2WorkloadSubnets = dependency.infrastructure.outputs.spoke2WorkloadSubnets
    spoke2SecurityGroup   = dependency.infrastructure.outputs.spoke2SecurityGroup    
}
