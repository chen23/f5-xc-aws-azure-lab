provider "aws" {
  region = var.awsRegion
}

provider "aws" {
  alias  = "peer"
  region = var.awsRegion2
}
