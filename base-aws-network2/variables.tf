variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}

variable "trusted_ip" {
  type        = string
  description = "IP to allow external access"
}

variable "namespace" {
  description = "Volterra application namespace"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "The DNS domain name that will be used as common parent generated DNS name of loadbalancers."
  default     = "shared.example.internal"
}

variable "awsRegion2" {
  description = "aws region"
  type        = string
}

variable "awsAz1" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz2" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz3" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}

variable "volterraP12" {
  description = "Location of volterra p12 file"
  type        = string
  default     = null
}
variable "volterraUrl" {
  description = "url of volterra api"
  type        = string
  default     = null
}
variable "volterraTenant" {
  description = "Tenant of Volterra"
  type        = string
}
variable "volterraCloudCredAWS" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "volterraCloudCredAzure" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "servicesVpcCidrBlock" {
  default = "100.64.32.0/20"
}
variable "servicesVpc" {
  description = "Services VPC"
  type        = map(any)
  default = {
    "azs" = {
      "az1" = { az = "us-west-1a" },
      "az2" = { az = "us-west-1b" },
      "az3" = { az = "us-west-1b" },
    },
    "external" = {
      "az1" = {
        cidr = "100.64.32.0/24"
      },
      "az2" = {
        cidr = "100.64.35.0/24"
      },
      "az3" = {
        cidr = "100.64.36.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "100.64.33.0/24"
      },
      "az2" = {
        cidr = "100.64.37.0/24"
      },
      "az3" = {
        cidr = "100.64.39.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "100.64.34.0/24"
      },
      "az2" = {
        cidr = "100.64.38.0/24"
      },
      "az3" = {
        cidr = "100.64.40.0/24"
      }
    }

  }
}
variable "spokeVpcCidrBlock" {
  default = "10.0.32.0/20"
}
variable "spokeVpc" {
  description = "Spoke VPC"
  type        = map(any)
  default = {
    "azs" = {
      "az1" = { az = "us-west-1a" },
      "az2" = { az = "us-west-1b" },
      "az3" = { az = "us-west-1b" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.32.0/24"
      },
      "az2" = {
        cidr = "10.0.35.0/24"
      },
      "az3" = {
        cidr = "10.0.38.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.33.0/24"
      },
      "az2" = {
        cidr = "10.0.36.0/24"
      },
      "az3" = {
        cidr = "10.0.39.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.34.0/24"
      },
      "az2" = {
        cidr = "10.0.37.0/24"
      },
      "az3" = {
        cidr = "10.0.40.0/24"
      }
    }

  }
}