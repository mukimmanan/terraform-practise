# variable "<VARIABLE_NAME>" {
#   type = "<VARIABLE_TYPE>"
#   description = "<DESCRIPTION>"
#   default = "<EXPRESSION>"
#   sensitive = "<BOOLEAN>"
#   validation = "<RULES>"
# }

variable "aws_region" {
  type = string
  description = "region used to deploy resources"
  default = "ap-south-1"
  validation {
    condition = can(regex("ap-"), var.aws_region)
    error_message = "The aws_region value must be a valid region in ASIA"
  }
}