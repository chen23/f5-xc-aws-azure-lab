terraform {


}

inputs = {
    projectPrefix          = "menger"
    namespace              = "m-menger"
    trusted_ip             = "192.0.1.0/32"
    volterraTenant         = "f5-sa"
    volterraCloudCredAWS   = "m-menger-aws-cred"
    volterraCloudCredAzure = "m-menger-azure-cred"
    awsRegion              = "us-east-1"
}