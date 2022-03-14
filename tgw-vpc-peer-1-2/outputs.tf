output "AWS_INSTANCE" {
  value = aws_instance.f5-jumphost-1.public_ip
}
