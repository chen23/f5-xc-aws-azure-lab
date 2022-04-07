output "nlbdnsname" {
  value = aws_lb.ext-nlb-tgw1.dns_name
}
output "route53ips" {
  value = aws_route53_resolver_endpoint.tgw1[0].ip_address
}
output "route54zoneid" {
  value = aws_route53_zone.private.zone_id
}
