provider "aws" {
  region = var.awsRegion
}
resource "aws_lb" "ext-nlb-tgw1" {
  name               = "${var.projectPrefix}-ext-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [for subnet in var.externalSubnets : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "${var.projectPrefix}-ext-nlb"
  }
}

resource "aws_lb_listener" "ext-nlb-tgw1-80" {
  load_balancer_arn = aws_lb.ext-nlb-tgw1.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgw1-tg.arn
  }
}

data "aws_instances" "xcmesh-tgw1" {
  instance_state_names = ["running"]
  instance_tags = {
    "ves-io-site-name" = "${var.projectPrefix}-tgw-1"
  }
}

resource "aws_lb_target_group" "tgw1-tg" {
  name     = "${var.projectPrefix}-tgw-1-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpcId
}

resource "aws_lb_target_group_attachment" "tgw1-attach" {
  for_each         = toset(data.aws_instances.xcmesh-tgw1.ids)
  target_group_arn = aws_lb_target_group.tgw1-tg.arn
  target_id        = each.value
  port             = 80
}