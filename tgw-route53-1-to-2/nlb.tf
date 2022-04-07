resource "aws_lb" "ext-nlb-tgw2" {
  provider           = aws.peer
  name               = "${var.projectPrefix}-ext-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [for subnet in var.externalSubnets2 : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "${var.projectPrefix}-ext-nlb"
  }
}

resource "aws_lb_listener" "ext-nlb-tgw2-80" {
  provider          = aws.peer
  load_balancer_arn = aws_lb.ext-nlb-tgw2.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgw2-tg.arn
  }
}

data "aws_instances" "xcmesh-tgw2" {
  provider             = aws.peer
  instance_state_names = ["running"]
  instance_tags = {
    "ves-io-site-name" = "${var.projectPrefix}-tgw-2"
  }
}

resource "aws_lb_target_group" "tgw2-tg" {
  provider = aws.peer
  name     = "${var.projectPrefix}-tgw-2-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpcId2
}

resource "aws_lb_target_group_attachment" "tgw2-attach" {
  provider         = aws.peer
  for_each         = toset(data.aws_instances.xcmesh-tgw2.ids)
  target_group_arn = aws_lb_target_group.tgw2-tg.arn
  target_id        = each.value
  port             = 80
}