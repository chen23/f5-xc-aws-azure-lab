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
variable "route54zoneid" {}
variable "tgw1nlbdns" {}
variable "securityGroup2" {}