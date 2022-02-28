data "template_file" "tgw_tfvars" {
  template = file("../tgw-site/terraform.tfvars.json.example")
  vars = {
    projectPrefix          = var.projectPrefix
    namespace              = var.namespace
    trusted_ip             = var.trusted_ip
    volterraCloudCredAWS   = var.volterraCloudCredAWS
    volterraCloudCredAzure = var.volterraCloudCredAzure
    volterraTenant         = var.volterraTenant
    awsRegion              = var.awsRegion
    awsAz1                 = var.servicesVpc.azs["az1"]["az"]
    awsAz2                 = var.servicesVpc.azs["az2"]["az"]
    awsAz3                 = var.servicesVpc.azs["az3"]["az"]
    externalSubnets        = jsonencode(aws_subnet.f5-xc-services-external)
    internalSubnets        = jsonencode(aws_subnet.f5-xc-services-internal)
    workloadSubnets        = jsonencode(aws_subnet.f5-xc-services-workload)
    spokeExternalSubnets   = jsonencode(aws_subnet.f5-xc-spoke-external)
    spokeWorkloadSubnets   = jsonencode(aws_subnet.f5-xc-spoke-workload)
    securityGroup          = aws_security_group.f5-xc-vpc.id
    vpcId                  = aws_vpc.f5-xc-services.id,
    spokeVpcId             = aws_vpc.f5-xc-spoke.id,
    spokeSecurityGroup     = aws_security_group.f5-xc-spoke-vpc.id
  }
}
output awsRegion {
  value = var.awsRegion
}
output awsAz1 {
  value = var.servicesVpc.azs["az1"]["az"]
}
output awsAz2 {
  value = var.servicesVpc.azs["az2"]["az"]
}
output awsAz3 {
  value = var.servicesVpc.azs["az3"]["az"]
}
output externalSubnets {
  value = aws_subnet.f5-xc-services-external
}
output internalSubnets {
  value = aws_subnet.f5-xc-services-internal
}
output workloadSubnets {
  value = aws_subnet.f5-xc-services-workload
}
output spokeExternalSubnets { 
  value   = aws_subnet.f5-xc-spoke-external
}
output spokeWorkloadSubnets {
  value = aws_subnet.f5-xc-spoke-workload
}
output securityGroup {
  value   = aws_security_group.f5-xc-vpc.id
}
output vpcId {
  value = aws_vpc.f5-xc-services.id
}
output spokeVpcId{
  value = aws_vpc.f5-xc-spoke.id
}
output spokeSecurityGroup {
  value = aws_security_group.f5-xc-spoke-vpc.id
}




