resource "aws_s3_bucket" "terraform_config" {
    bucket = "${var.application}-config"
    acl = "private"
    versioning {
      enabled = true
    }
    tags {
      Name = "${var.application}-bucket"
      Owner ="${var.owner}"
      Application = "${var.application}"
      Terraform = "true"
    }
}

output "terraform_bucket_id" {
  value = "${aws_s3_bucket.terraform_config.id}"
}
