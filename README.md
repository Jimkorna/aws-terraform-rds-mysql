# Tost RDS MySQL on AWS (OpenTofu)

Infrastructure-as-code for a small **MySQL database on AWS RDS** in the Mumbai region (`ap-south-1`).
The database is reachable only from an admin workstation (for example DBeaver) and from an existing EC2 instance.

## What it creates

| Resource | Purpose |
|---|---|
| `aws_security_group` | Allows MySQL (3306) only from the admin IP and from the EC2 security group |
| `aws_db_subnet_group` | Tells RDS which existing subnets (AZs) it can use |
| `aws_db_instance` | MySQL 8.0, `db.t3.micro`, 20 GB gp2, single-AZ |

The VPC, subnets and the EC2 security group are **not** created here. They must already exist.

## Project structure

```
.
├── versions.tf             # OpenTofu/Terraform and provider versions
├── providers.tf            # AWS provider
├── variables.tf            # All input variables
├── terraform.auto.tfvars   # Values for the variables (loaded automatically)
├── security_group.tf       # RDS security group
├── rds.tf                  # DB subnet group and RDS instance
└── outputs.tf              # RDS endpoint
```

## Prerequisites

- [OpenTofu](https://opentofu.org/) (or Terraform) installed
- AWS credentials configured (`aws configure` or environment variables)
- An existing VPC, two subnets in different AZs, and the security group of the EC2 instance

## Usage

1. Edit `terraform.auto.tfvars` with your VPC, subnet, security group IDs and your public IP (`x.x.x.x/32`).
2. Provide the database password through an environment variable. It is never stored in the repository:

   ```bash
   export TF_VAR_db_password='<strong-password>'
   ```

3. Deploy:

   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

4. Get the connection endpoint:

   ```bash
   tofu output rds_endpoint
   ```

5. Remove everything when it is no longer needed:

   ```bash
   tofu destroy
   ```

## Variables

| Name | Description | Default |
|---|---|---|
| `aws_region` | AWS region | `ap-south-1` |
| `vpc_id` | Existing VPC ID | n/a |
| `subnet_ids` | Existing subnet IDs (at least 2 AZs) | n/a |
| `ec2_sg_id` | Security group ID of the EC2 instance allowed to connect | n/a |
| `my_ip_cidr` | Admin public IP in CIDR notation | n/a |
| `db_identifier` | RDS instance identifier | `tost-database-instance` |
| `db_name` | Initial database name | `tost` |
| `db_username` | Master username | `admin` |
| `db_password` | Master password (**sensitive**) | n/a |
| `db_engine_version` | MySQL version | `8.0` |
| `db_instance_class` | Instance size | `db.t3.micro` |
| `db_allocated_storage` | Storage in GiB | `20` |
| `db_storage_type` | Storage type | `gp2` |
| `db_publicly_accessible` | Public endpoint | `true` |

## Outputs

| Name | Description |
|---|---|
| `rds_endpoint` | Database endpoint in `host:port` format |

## Notes

- This setup is meant for **development/testing**. The database is publicly accessible (protected by the security group), not encrypted, single-AZ, and has no final snapshot on destroy.
- Your home IP changes over time. Update `my_ip_cidr` if you lose access.
- Never commit `terraform.tfstate`: it contains the database password in plain text.
