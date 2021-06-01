data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Removed as using SSM for console access
#Create key-pair for logging into EC2
#resource "aws_key_pair" "webserver-key" {
#  key_name   = "webserver-key"
#  public_key = file("~/.ssh/id_rsa.pub")
#}

resource "aws_instance" "wg" {
  instance_type = var.InstanceType
  ami      = data.aws_ami.amazon_linux.id
  # Currently using SSM instead of keypair
  #key_name             = aws_key_pair.webserver-key.key_name
  security_groups      = [aws_security_group.instance.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_access_role.name
  subnet_id = module.vpc.public_subnets[0]
  source_dest_check = false

  #  user_data = file("userdata.sh")
  user_data = data.template_file.init.rendered
  root_block_device {
    volume_type = "gp2"
    encrypted   = true
  }

}
