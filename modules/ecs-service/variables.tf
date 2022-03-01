variable "cluster-id" {
  type        = string
  description = "set in here the CIDR for your VPC"
}
variable "family" {
  type        = string
  description = "set in here the CIDR for your VPC"
}
variable "revesion" {
  type        = string
  description = "set in here the CIDR for your VPC"
}

variable "listenerarn" {
  type        = string
  description = "set in here the CIDR for your VPC"
}
variable "env" {
  type        = string
  description = "set the env name here"
}
variable "subnet1_id" {
  type        = string
  description = "set the env name here"
}
variable "subnet3_id" {
  type        = string
  description = "set the env name here"
}
variable "sgid" {
  type        = string
  description = "set the env name here"
}
variable "service-sgid" {
  type        = string
  description = "set the env name here"
}

variable "tgid" {
  type        = string
  description = "set the env name here"
}
variable "vpc_id1" {
  type        = string
  description = "set in here the CIDR for your Subnet"
}