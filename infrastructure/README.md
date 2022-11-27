


Commands:
terraform init #installs packages
terraform plan #dry run of what it will create/destroy
terraform apply #creates resources
terraform destroy #Destroys all resources that it created
terraform destroy -target aws_instance.myec2  #Destroy specific resources with a flag
terraform plan -var-file=terraform.tfvars #useful if you are defining values in different files.


#todo remove



## Terraform

https://medium.com/hootsuite-engineering/how-to-use-terraform-and-remote-state-with-s3-ed4320ee324a

### Terraform State files
https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
