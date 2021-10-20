variable "app_tags" {
  type = string
}

variable "application_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_subnets" {
  type = string
}

variable "elb_subnets" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "keypair" {
  type = string
}

variable "certificate" {
  type = string
}

variable "sshrestrict" {
  type = string
}