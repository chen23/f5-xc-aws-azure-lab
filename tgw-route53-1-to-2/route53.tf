
resource "aws_route53_health_check" "tgw1" {
  ip_address        = var.mesh_public_ips[0]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-1-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "tgw1b" {
  ip_address        = var.mesh_public_ips[1]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-1b-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "tgw1c" {
  ip_address        = var.mesh_public_ips[2]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-1c-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "tgw2" {
  ip_address        = var.mesh_public_ips2[0]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-2-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "tgw2b" {
  ip_address        = var.mesh_public_ips2[1]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-2b-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "tgw2c" {
  ip_address        = var.mesh_public_ips2[2]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-tgw-2c-healthcheck", var.projectPrefix)
  }
}


resource "aws_route53_health_check" "azure1" {
  ip_address        = var.mesh_public_ips3[0]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-1-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "azure1b" {
  ip_address        = var.mesh_public_ips3[1]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-1b-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "azure1c" {
  ip_address        = var.mesh_public_ips3[2]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-1c-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "azure2" {
  ip_address        = var.mesh_public_ips4[0]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-2-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "azure2b" {
  ip_address        = var.mesh_public_ips4[1]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-2b-healthcheck", var.projectPrefix)
  }
}

resource "aws_route53_health_check" "azure2c" {
  ip_address        = var.mesh_public_ips4[2]
  port              = 80
  type              = "TCP"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = format("%s-azure-2c-healthcheck", var.projectPrefix)
  }
}


resource "aws_route53_record" "globalworkloadtgw1" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw1.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-1", var.projectPrefix)

  records = [var.mesh_private_ips[0]]
}

resource "aws_route53_record" "globalworkloadtgw1b" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw1b.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-1b", var.projectPrefix)

  records = [var.mesh_private_ips[1]]
}

resource "aws_route53_record" "globalworkloadtgw1c" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw1c.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-1c", var.projectPrefix)

  records = [var.mesh_private_ips[2]]
}

resource "aws_route53_record" "globalworkloadtgw2" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw2.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-2", var.projectPrefix)

  records = [var.mesh_private_ips2[0]]
}

resource "aws_route53_record" "globalworkloadtgw2b" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw2b.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-2b", var.projectPrefix)

  records = [var.mesh_private_ips2[1]]
}

resource "aws_route53_record" "globalworkloadtgw2c" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.tgw2c.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-tgw-2c", var.projectPrefix)

  records = [var.mesh_private_ips2[2]]
}


resource "aws_route53_record" "globalworkloadazure1" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure1.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-1", var.projectPrefix)

  records = [var.mesh_private_ips3[0]]
}

resource "aws_route53_record" "globalworkloadazure1b" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure1b.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-1b", var.projectPrefix)

  records = [var.mesh_private_ips3[1]]
}

resource "aws_route53_record" "globalworkloadazure1c" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure1c.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-1c", var.projectPrefix)

  records = [var.mesh_private_ips3[2]]
}


resource "aws_route53_record" "globalworkloadazure2" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure2.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-2", var.projectPrefix)

  records = [var.mesh_private_ips4[0]]
}

resource "aws_route53_record" "globalworkloadazure2b" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure2b.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-2b", var.projectPrefix)

  records = [var.mesh_private_ips4[1]]
}

resource "aws_route53_record" "globalworkloadazure2c" {
  zone_id = var.route54zoneid
  name    = "*.global.example.internal"
  type    = "A"
  ttl     = "300"

  health_check_id = aws_route53_health_check.azure2c.id

  multivalue_answer_routing_policy = true

  set_identifier = format("%s-azure-2c", var.projectPrefix)

  records = [var.mesh_private_ips4[2]]
}



resource "aws_route53_zone" "private" {
  provider = aws.peer
  name     = "example.internal"

  vpc {
    vpc_id = var.vpcId2
  }
}




# resource "aws_route53_record" "tgw2workload" {
#   provider = aws.peer
#   zone_id  = aws_route53_zone.private.zone_id
#   name     = "workload.tgw2.example.internal"
#   type     = "CNAME"
#   ttl      = "300"
#   records  = [aws_lb.ext-nlb-tgw2.dns_name]
# }

resource "aws_route53_resolver_endpoint" "tgw2" {
  provider  = aws.peer
  count     = 1
  name      = "tgw2"
  direction = "INBOUND"

  security_group_ids = [
    var.securityGroup2
  ]

  ip_address {
    subnet_id = var.externalSubnets2["az1"].id
  }

  ip_address {
    subnet_id = var.externalSubnets2["az2"].id
  }

}

# resource "aws_route53_record" "globalworkloadtgw2" {
#   provider = aws.peer
#   zone_id  = aws_route53_zone.private.zone_id

#   name = "workload.global.example.internal"
#   type = "CNAME"
#   ttl  = "300"

#   records = [aws_lb.ext-nlb-tgw2.dns_name]
# }
