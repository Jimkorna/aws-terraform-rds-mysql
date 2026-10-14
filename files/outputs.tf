# DNS endpoint (host:port) used to connect to the database.
output "rds_endpoint" {
  description = "RDS endpoint in host:port format"
  value       = aws_db_instance.mysql_tost.endpoint
}
