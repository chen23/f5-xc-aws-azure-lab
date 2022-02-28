resource "volterra_aws_tgw_site" "aws-region-1" {
  name        = format("%s-tgw-1", var.projectPrefix)
  namespace   = "system"
#  description = format("Virtual site for %s-%s", var.projectPrefix, local.buildSuffix)

  vpc_attachments {
    vpc_list {
      vpc_id = var.spokeVpcId
    }
  }

  aws_parameters {
    aws_certified_hw = "aws-byol-multi-nic-voltmesh"
    aws_region       = var.awsRegion
    
    vpc_id = var.vpcId
    
    new_tgw {
      system_generated = true
    }


    az_nodes {
      aws_az_name = var.awsAz1
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az1"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az1"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az1"].id            
      }      
    }

    az_nodes {
      aws_az_name = var.awsAz2
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az2"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az2"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az2"].id            
      }      
    }

    az_nodes {
      aws_az_name = var.awsAz3
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az3"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az3"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az3"].id            
      }      
    }
    aws_cred {
      name = var.volterraCloudCredAWS
      namespace = "system"      
    }
    assisted = false
    instance_type = "t3.xlarge"
  }
  logs_streaming_disabled = true
}

resource "volterra_tf_params_action" "aws-region-1" {
  site_name        = volterra_aws_tgw_site.aws-region-1.name
  site_kind        = "aws_tgw_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = false

  depends_on = [volterra_aws_tgw_site.aws-region-1]
}

########################### Providers ##########################
provider "aws" {
  region = var.awsRegion
}
# Instance info
data "aws_instances" "xcmesh" {
  instance_state_names = ["running"]
  instance_tags = {
    "ves-io-site-name" = volterra_aws_tgw_site.aws-region-1.name
  }

  depends_on = [volterra_tf_params_action.aws-region-1]
}