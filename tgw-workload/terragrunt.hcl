include "root" {
  path = find_in_parent_folders()
}

terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = {
            VOLT_API_TIMEOUT  = "60s"
        }
    }

    before_hook "pre-check" {
        commands = ["apply","plan","destroy"]
        execute  = ["./pre-check.sh"]
    }

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
    spoke2ExternalSubnets = dependency.infrastructure.outputs.spoke2ExternalSubnets
    spoke2WorkloadSubnets = dependency.infrastructure.outputs.spoke2WorkloadSubnets
    spoke2SecurityGroup   = dependency.infrastructure.outputs.spoke2SecurityGroup    
}