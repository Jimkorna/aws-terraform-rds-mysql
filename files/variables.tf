# ---------------------------------------------------------------------------
# General
# ---------------------------------------------------------------------------
variable "aws_region" {
  description = "AWS region where all resources are created"
  type        = string
  default     = "ap-south-1" # Mumbai
}

# ---------------------------------------------------------------------------
# Existing network resources (these are NOT created by this project)
# ---------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the existing VPC in which the RDS security group is created"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of existing subnets (in at least two AZs) used for the DB subnet group"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security group ID of the EC2 instance that is allowed to reach the database"
  type        = string
}

variable "my_ip_cidr" {
  description = "Public IP of the admin workstation in CIDR notation (e.g. 1.2.3.4/32), used for DBeaver access"
  type        = string
}

# ---------------------------------------------------------------------------
# Database settings
# ---------------------------------------------------------------------------
variable "db_identifier" {
  description = "Identifier of the RDS instance"
  type        = string
  default     = "tost-database-instance"
}

variable "db_name" {
  description = "Name of the initial database created inside the instance"
  type        = string
  default     = "tost"
}

variable "db_username" {
  description = "Master username of the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password of the database. Do not commit it; pass it with TF_VAR_db_password"
  type        = string
  sensitive   = true
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "RDS instance size"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GiB"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "EBS storage type for the database"
  type        = string
  default     = "gp2"
}

variable "db_publicly_accessible" {
  description = "Whether the instance gets a public endpoint (access is still restricted by the security group)"
  type        = bool
  default     = true
}
