
variable "vpc_id1" {
    default = ""
}

variable "alb-sg" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}
variable "subnet1_id" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}

variable "subnet3_id" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}



variable "env" {
  type        = string
  description = "set the env name here"
}
