variable "instance_type" {
  description = "Enter the Instance Type"
  type        = string
  default = "t2.micro"
}

variable "az" {
  description = "Enter Availability Zone"
  type        = string
  default = "ap-southeast-1b"
}

variable "vpc_cidr" {
    description = "VPC CIDR Range"
}

variable "azs" {
  description = "Enter availability Zone"
  type        = list
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

}

variable "subnets" {
    description = "Subnet CIDR ranges"
    type = list
}

data "aws_availability_zones" "data_azs" {
    state = "available"

}