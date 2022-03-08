variable "application_name" {
  type        = string
  description = "The name of your application"
  default     = "nazare"
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "The Azure region where all resources in this example should be created"
  default     = "westeurope"
}

variable "isProd" {
  type        = bool
  description = "is prod"
  default     = false
}


# variable "sg_Resource_ControlTower_Profile" {
#   type = string
# }
