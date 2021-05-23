# Variable declarations
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "project_name" {
  description = "Project identifier to be used as the seed for others"
  default     = "wg-2"
}

variable "Hostname" {
  description = "Hostname of the server which will be created"
  default     = "instance-bobbins1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "instance_security_group_name" {
  description = "The name of the security group for the EC2 Instances"
  type        = string
  default     = "instance-sg"
}

variable "InstanceType" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "server_port" {
  description = "Port for wg"
  default     = "54321"
}
