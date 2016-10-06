# Goal

- Store the tfstate files in s3 (versioned) so it's easy for collaboration and don't have to checkin the file in source control.
- Maintain separate tfstate files for each layer of the infrastructure as desired.

# Create an s3 bucket to store terraform configs.

- Update values in terraform.tfvars

```sh
cd init
terraform plan
terraform apply
```

- Note: You won't be able to run terraform destroy on this as the state file is stored on the same bucket
- You will have to create an output variable of those that you need to use later

```sh

output "terraform_bucket_id" {
  value = "${aws_s3_bucket.terraform_config.id}"
}
```

- Now that you have the bucket created, update terraform to use s3 bucket as source to store the state file by running the init.sh script
- Update init.sh if you have to, with your bucket name

```sh
chmod +x init.sh
./init.sh
```

- At this point you will see that terraform.tfstate file has been moved to .terraform/terraform.tfstate and the state file has been added to s3
- You can refer the output values from this state file to build other layers of your infrastructure

# Make use of resources created in init in different terraform layer.

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

## References:

- <https://www.terraform.io/docs/state/remote/s3.html>
- <https://www.terraform.io/intro/getting-started/outputs.html>
- <https://www.terraform.io/docs/commands/remote-config.html>
- <https://charity.wtf/2016/03/30/terraform-vpc-and-why-you-want-a-tfstate-file-per-env/>
