# Loaded automatically by terraform/tofu (no -var-file flag needed).
# Do NOT put secrets here. Export the password instead:
#   export TF_VAR_db_password='...'

aws_region = "ap-south-1" # Mumbai

# Existing network resources
vpc_id     = "vpc-4e819a26"
subnet_ids = ["subnet-77fe450c", "subnet-4ae3e322"] # one subnet per AZ
ec2_sg_id  = "sg-0ea8c65f827de5b95"                 # EC2 security group allowed to connect

# Home public IP (changes over time - update it if DBeaver cannot connect)
my_ip_cidr = "5.54.11.199/32"
