variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}

variable "azureRegion2" {
  type        = string
  description = "target azure region"
}

variable "resourceGroup" {
  description = "The name of the resource group in which the virtual networks are created"
  default     = "f5demo_rg"
}

variable "location" {
  description = "The location/region where the virtual networks are created. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "trusted_ip" {
  description = "IP address of trusted source for mgmt/testing"
  default     = "192.0.2.10/32"
}
variable "servicesVnetAddressSpace" {
  default = "100.64.64.0/20"
}

variable "servicesVnetExternalSubnet" {
  default = "100.64.64.0/24"
}

variable "servicesVnetInternalSubnet" {
  default = "100.64.65.0/24"
}

variable "servicesVnetWorkloadSubnet" {
  default = "100.64.66.0/24"
}

variable "servicesVnetGatewaySubnet" {
  default = "100.64.67.0/24"
}

variable "spokeVnetAddressSpace" {
  default = "10.2.16.0/20"
}

variable "spokeVnetExternalSubnet" {
  default = "10.2.16.0/24"
}

variable "spokeVnetInternalSubnet" {
  default = "10.2.17.0/24"
}

variable "spokeVnetWorkloadSubnet" {
  default = "10.2.18.0/24"
}
