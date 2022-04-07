resource "aws_route53_zone" "private" {
  name = "example.internal"

  vpc {
    vpc_id = var.vpcId
  }
}


resource "aws_route53_record" "tgw1workload" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "workload.tgw1.example.internal"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.ext-nlb-tgw1.dns_name]
}

resource "aws_route53_resolver_endpoint" "tgw1" {
  count     = 1
  name      = "tgw1"
  direction = "INBOUND"

  security_group_ids = [
    var.securityGroup
  ]

  ip_address {
    subnet_id = var.externalSubnets["az1"].id
  }

  ip_address {
    subnet_id = var.externalSubnets["az2"].id
  }

}