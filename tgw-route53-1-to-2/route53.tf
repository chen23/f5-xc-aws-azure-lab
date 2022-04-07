

resource "aws_route53_record" "globalworkloadtgw1" {
  zone_id = var.route54zoneid
  name    = "workload.global.example.internal"
  type    = "CNAME"
  ttl     = "300"

  records = [var.tgw1nlbdns]
}

resource "aws_route53_zone" "private" {
  provider = aws.peer
  name     = "example.internal"

  vpc {
    vpc_id = var.vpcId2
  }
}


resource "aws_route53_record" "tgw2workload" {
  provider = aws.peer
  zone_id  = aws_route53_zone.private.zone_id
  name     = "workload.tgw2.example.internal"
  type     = "CNAME"
  ttl      = "300"
  records  = [aws_lb.ext-nlb-tgw2.dns_name]
}

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

resource "aws_route53_record" "globalworkloadtgw2" {
  provider = aws.peer
  zone_id  = aws_route53_zone.private.zone_id

  name = "workload.global.example.internal"
  type = "CNAME"
  ttl  = "300"

  records = [aws_lb.ext-nlb-tgw2.dns_name]
}
