# ---------------------------------------------------------------------------
# DB subnet group: tells RDS which subnets (AZs) it may place the instance in.
# ---------------------------------------------------------------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "tost-db-subnet-group"
  subnet_ids = var.subnet_ids
}

# ---------------------------------------------------------------------------
# RDS MySQL instance (single-AZ, small dev/test setup).
# ---------------------------------------------------------------------------
resource "aws_db_instance" "mysql_tost" {
  identifier        = var.db_identifier
  engine            = "mysql"
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type

  # Initial database and master credentials
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # Networking
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = var.db_publicly_accessible

  # Convenience settings for a test DB:
  # no final snapshot on destroy, apply changes immediately instead of in the maintenance window
  skip_final_snapshot = true
  apply_immediately   = true
}
