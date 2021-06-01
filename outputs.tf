#output "ec2_ip" {
# value = ec2_instances.e
#}

#output "aws_region" {
#  description = "Region"
#  value       = var.aws_region.name
#}

output "project_name" {
  description = "Project identifier to be used as the seed for others"
  value       = var.project_name
}


output "external_ip" {
  description = "External IP for the EC2 instance"
  value       = aws_instance.wg.public_ip
}
