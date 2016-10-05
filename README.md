## Create an s3 bucket to store terraform configs.

- Note: You won't be able to run terraform destroy on this as the state file is stored on the same bucket
- Update values in terraform.tfvars

```sh
cd init
terraform plan
terraform apply

```
- Now that you have the bucket created, upload the terraform.tfstate to the s3 bucket that you created.
- Update init.sh if you have to with your bucket name

```sh
chmod +x init.sh
./init.sh
```

- At this point you will see that terraform.tfstate file has been moved to .terraform/terraform.tfstate and the state file has been added to s3
- You can refer the output values from this state file to build other layers of your infrastructure

## Make use of resources created in init in different terraform layer.

- This is incredibly useful while building different environments of your infrastructure.
- You can update individual environments without the risk of inadvertently affecting something else
- base.tf creates an s3 object. Bucket name is obtained from the init.tfstate file


```sh
cd base
chmod +x init.sh
./init.sh
terraform plan -var-file=./base.tfvars
terraform apply -var-file=./base.tfvars
```
