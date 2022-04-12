variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}
variable "awsRegion" {
  description = "aws region"
  type        = string
}
variable "awsRegion2" {
  description = "aws region"
  type        = string
}
variable "vpcId" {}
variable "vpcId2" {}
variable "externalSubnets" {
  type = map(any)
}
variable "externalSubnets2" {
  type = map(any)
}
variable "mesh_public_ips" {
  type = list(string)
}

variable "mesh_public_ips2" {
  type = list(string)
}

variable "mesh_public_ips3" {
  type = list(string)
}

variable "mesh_public_ips4" {
  type = list(string)
}

variable "mesh_private_ips" {
  type = list(string)
}

variable "mesh_private_ips2" {
  type = list(string)
}

variable "mesh_private_ips3" {
  type = list(string)
}

variable "mesh_private_ips4" {
  type = list(string)
}

variable "route54zoneid" {}
variable "tgw1nlbdns" {}
variable "securityGroup2" {}
