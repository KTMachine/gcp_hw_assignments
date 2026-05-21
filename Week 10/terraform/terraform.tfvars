# Defaults that are used for Variables that are not set 
# in terraform.tfvars or environment variables

project_id = "invictus-65"
region     = "us-central1"
zone       = "us-central1-a"

vpc_name    = "custom-vpc"
subnet_cidr = "10.11.0.0/24"

frontend_mig_name = "frontend-mig"
backend_mig_name  = "backend-mig"

mig_min_instances = 3
mig_max_instances = 6


bucket_name = "invictus-65-static"

lb_name = "hw-lb"