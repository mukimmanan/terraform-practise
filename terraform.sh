terraform init (# initialize the terraform object)
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy
terraform fmt

terraform init -upgrade (incase there is any update in terrafrom object)
terraform taint <resource name>
terraform apply -replace = <name of resource>

terraform import (imports existing resource from AWS to terraform)
# terraform import aws_instance.aws_linux <instance_id>

terraform workspace new/list/show/delete
terraform state

terraform plan -out <path where to store plan>
terraform apply <plan>
terraform init -migrate-state

terraform apply -lock-timeout=60s