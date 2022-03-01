variable awsRegion {
    type = string
}
variable projectPrefix {
    type = string
}
variable ssh_key {
    type = string
}
variable spokeSecurityGroup {
    type = string
}
variable spokeExternalSubnets {
    type = map
}
variable spokeWorkloadSubnets {
    type = map
}


variable spoke2SecurityGroup {
    type = string
}
variable spoke2ExternalSubnets {
    type = map
}
variable spoke2WorkloadSubnets {
    type = map
}