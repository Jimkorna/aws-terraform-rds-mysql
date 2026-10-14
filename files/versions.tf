# Terraform / OpenTofu and provider version constraints.
# The original project was initialised with OpenTofu and aws provider 6.34.0
# (see .terraform.lock.hcl), so we pin to the same major version.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
