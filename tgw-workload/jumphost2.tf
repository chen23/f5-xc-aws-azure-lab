
resource "aws_instance" "f5-jumphost-2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = var.spoke2ExternalSubnets["az1"].id
  vpc_security_group_ids = [var.spoke2SecurityGroup]
  key_name               = var.ssh_key
  user_data              = <<-EOF
#!/bin/bash
sleep 30
snap install docker
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d -p 80:80 --net host -e F5DEMO_APP=website -e F5DEMO_NODENAME="AWS Environment (Jumphost2)" --restart always --name f5demoapp f5devcentral/f5-demo-httpd:nginx
              EOF

  tags = {
    Name = "${var.projectPrefix}-f5-xc-jumphost-2"
  }
}

