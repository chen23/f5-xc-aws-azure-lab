include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../base-aws-network"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
}

inputs = {
    awsAz1               = dependency.infrastructure.outputs.awsAz1
    awsAz2               = dependency.infrastructure.outputs.awsAz2
    awsAz3               = dependency.infrastructure.outputs.awsAz3
    externalSubnets      = dependency.infrastructure.outputs.externalSubnets
    internalSubnets      = dependency.infrastructure.outputs.internalSubnets
    workloadSubnets      = dependency.infrastructure.outputs.workloadSubnets
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    securityGroup        = dependency.infrastructure.outputs.securityGroup
    vpcId                = dependency.infrastructure.outputs.vpcId
    spokeVpcId           = dependency.infrastructure.outputs.spokeVpcId
    spoke2VpcId           = dependency.infrastructure.outputs.spoke2VpcId    
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
}