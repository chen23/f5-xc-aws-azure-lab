data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "f5-jumphost-1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.f5-xc-ext-client-external.id
  vpc_security_group_ids = [aws_security_group.f5-xc-sg.id]
  key_name               = var.ssh_key
  user_data              = <<-EOF
#!/bin/bash
sleep 30
snap install docker
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d -p 80:80 --net host -e F5DEMO_APP=website -e F5DEMO_NODENAME="AWS Environment (Jumphost)" --restart always --name f5demoapp f5devcentral/f5-demo-httpd:nginx
              EOF

  tags = {
    Name = "${var.projectPrefix}-f5-xc-client-jumphost-1"
  }
}

