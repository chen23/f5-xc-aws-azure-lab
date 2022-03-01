output "AWS_INSTANCE" {
  value = aws_instance.f5-jumphost-1.public_ip
}

output workload_ip {
  value = aws_instance.f5-workload-1.private_ip
}

