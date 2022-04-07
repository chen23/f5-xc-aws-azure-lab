output "nlbdnsname" {
  value = aws_lb.ext-nlb-tgw2.dns_name
}
output "route53ips" {
  value = aws_route53_resolver_endpoint.tgw2[0].ip_address
}
