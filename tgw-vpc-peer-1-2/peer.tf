provider "aws" {
  region = var.awsRegion
}

provider "aws" {
  alias  = "peer"
  region = var.awsRegion2
}

data "aws_caller_identity" "current" {}

resource "aws_vpc_peering_connection" "peer-tgw-1-2" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.vpcId2
  peer_region   = var.awsRegion2
  vpc_id        = var.vpcId
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-1-2.id
  auto_accept               = true
}

resource "aws_route" "serviceRoute" {
  route_table_id            = var.serviceExternalRouteTable
  destination_cidr_block    = var.serviceCidrBlock2
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-1-2.id
}

resource "aws_route" "serviceRoute2" {
  provider                  = aws.peer
  route_table_id            = var.serviceExternalRouteTable2
  destination_cidr_block    = var.serviceCidrBlock
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-1-2.id
}

resource "aws_vpc_peering_connection" "peer-tgw-1-client" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.vpcId
  vpc_id        = aws_vpc.f5-xc-ext-client.id
  auto_accept = true
}

resource "aws_vpc_peering_connection" "peer-tgw-2-client" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.vpcId2
  peer_region   = var.awsRegion2  
  vpc_id        = aws_vpc.f5-xc-ext-client.id
}

resource "aws_vpc_peering_connection_accepter" "client" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-2-client.id
  auto_accept               = true
}


resource "aws_route" "serviceRouteClient" {
  route_table_id            = var.serviceExternalRouteTable
  destination_cidr_block    = "192.168.0.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-1-client.id
}

resource "aws_route" "serviceRoute2Client" {
  provider                  = aws.peer
  route_table_id            = var.serviceExternalRouteTable2
  destination_cidr_block    = "192.168.0.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-2-client.id
}

resource "aws_route" "clientRoute" {
  route_table_id = aws_route_table.f5-xc-client-external-rt.id
  destination_cidr_block  = var.serviceCidrBlock
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-1-client.id  
}

resource "aws_route" "clientRoute2" {
  route_table_id = aws_route_table.f5-xc-client-external-rt.id
  destination_cidr_block  = var.serviceCidrBlock2
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-tgw-2-client.id  
}