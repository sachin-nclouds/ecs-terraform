variable "vpc_cidr" {
  type        = string
  description = "set in here the CIDR for your VPC"
}

variable "subnet1_cidr" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}

variable "subnet2_cidr" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}
variable "subnet3_cidr" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}

variable "env" {
  type        = string
  description = "set the env name here"
}
