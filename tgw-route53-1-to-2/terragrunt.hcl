include "root" {
  path = find_in_parent_folders()
}


dependencies {
  paths = ["../tgw-site","../tgw-workload","../tgw-site2","../tgw-workload2","../tgw-apps","../tgw-site-ext-lb"]
}

dependency "workloads" {
  config_path = "../tgw-workload"
}

dependency "workloads2" {
  config_path = "../tgw-workload2"
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
}

dependency "infrastructure2" {
  config_path = "../base-aws-network2"
}

dependency "tgw1route53" {
  config_path = "../tgw-site-ext-lb"
}
inputs = {
    route54zoneid       = dependency.tgw1route53.outputs.route54zoneid
    tgw1nlbdns       = dependency.tgw1route53.outputs.nlbdnsname
    externalSubnets      = dependency.infrastructure.outputs.externalSubnets
    vpcId                = dependency.infrastructure.outputs.vpcId
    externalSubnets2      = dependency.infrastructure2.outputs.externalSubnets
    vpcId2                = dependency.infrastructure2.outputs.vpcId
    securityGroup2                = dependency.infrastructure2.outputs.securityGroup    
}

