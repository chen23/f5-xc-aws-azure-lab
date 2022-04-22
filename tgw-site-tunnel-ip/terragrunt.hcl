include "root" {
  path = find_in_parent_folders()
}

terraform {

    before_hook "pre-check" {
        commands = ["apply","plan"]
        execute  = ["./tunnel-ip.sh"]
    }

}


dependencies {
  paths = ["../base-aws-network","../tgw-site","../base-aws-network2","../tgw-site2"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
}

dependency "site" {
  config_path = "../tgw-site"
}
dependency "site2" {
  config_path = "../tgw-site2"
}

inputs = {
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
    spoke2ExternalSubnets = dependency.infrastructure.outputs.spoke2ExternalSubnets
    spoke2WorkloadSubnets = dependency.infrastructure.outputs.spoke2WorkloadSubnets
    spoke2SecurityGroup   = dependency.infrastructure.outputs.spoke2SecurityGroup
    xcmesh                = dependency.site.outputs.xcmesh
    xcmesh2                = dependency.site2.outputs.xcmesh    
}