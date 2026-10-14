# ---------------------------------------------------------------------------
# Security group for the RDS instance.
# Only two sources can reach MySQL (port 3306):
#   1. the admin workstation (for DBeaver)
#   2. the EC2 instance's security group
# ---------------------------------------------------------------------------
resource "aws_security_group" "rds_sg" {
  name        = "tost-rds-mysql-sg"
  description = "Allow MySQL Port 3306"
  vpc_id      = var.vpc_id

  # Access from the admin's PC (e.g. DBeaver)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  # Access from the EC2 instance (referenced by its security group)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}
