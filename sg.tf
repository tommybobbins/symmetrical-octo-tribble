
resource "aws_security_group" "instance" {
  vpc_id = module.vpc.vpc_id
  name   = var.instance_security_group_name

  # Allow inbound wg requests
  ingress {
    from_port   = 54321
    to_port     = 54321 
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH requests
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
