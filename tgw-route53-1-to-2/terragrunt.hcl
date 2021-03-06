include "root" {
  path = find_in_parent_folders()
}


dependencies {
  paths = ["../tgw-site","../tgw-workload","../tgw-site2","../tgw-workload2","../tgw-apps","../tgw-site-ext-lb","../azure-site","../azure-site2"]
}

dependency "workloads" {
  config_path = "../tgw-workload"
  mock_outputs = {
  }
}

dependency "workloads2" {
  config_path = "../tgw-workload2"
  mock_outputs = {
  }
}

dependency "infrastructure" {
  config_path = "../base-aws-network"
  mock_outputs = {
    "externalSubnets" = {
      "az1" = {
        "id" = "1"
      }
    }
    vpcId = ""
  }
}

dependency "infrastructure2" {
  config_path = "../base-aws-network2"
  mock_outputs = {
    "externalSubnets" = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      }
    }
    vpcId = ""
    securityGroup = ""
  }
}

dependency "tgw1route53" {
  config_path = "../tgw-site-ext-lb"
  mock_outputs = {
    route54zoneid = "foo"
    nlbdnsname = ""
  }
}

dependency "site" {
  config_path = "../tgw-site"
  mock_outputs = {
    public_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
    private_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
  }
}
dependency "site2" {
  config_path = "../tgw-site2"
  mock_outputs = {
    public_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
    private_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
  }
}

dependency "site3" {
  config_path = "../azure-site"
  mock_outputs = {
    public_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
    private_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
  }
}
dependency "site4" {
  config_path = "../azure-site2"
  mock_outputs = {
    public_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
    private_ips = ["1.1.1.1","1.1.1.1","1.1.1.1"]
  }
}


inputs = {
    route54zoneid       = dependency.tgw1route53.outputs.route54zoneid
    tgw1nlbdns       = dependency.tgw1route53.outputs.nlbdnsname
    externalSubnets      = dependency.infrastructure.outputs.externalSubnets
    vpcId                = dependency.infrastructure.outputs.vpcId
    externalSubnets2      = dependency.infrastructure2.outputs.externalSubnets
    vpcId2                = dependency.infrastructure2.outputs.vpcId
    securityGroup2                = dependency.infrastructure2.outputs.securityGroup
    mesh_public_ips                = dependency.site.outputs.public_ips
    mesh_public_ips2                = dependency.site2.outputs.public_ips
    mesh_public_ips3                = dependency.site3.outputs.public_ips
    mesh_public_ips4                = dependency.site4.outputs.public_ips
    mesh_private_ips                = dependency.site.outputs.private_ips
    mesh_private_ips2                = dependency.site2.outputs.private_ips
    mesh_private_ips3                = dependency.site3.outputs.private_ips
    mesh_private_ips4                = dependency.site4.outputs.private_ips    

}

