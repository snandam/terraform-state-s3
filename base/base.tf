
### Defining the init state file to refer
data "terraform_remote_state" "init_state" {
  backend = "s3"
  config {
    bucket = "${var.application}-config"
    region = "${var.aws_region}"
    key = "${var.init_state_file}"
  }
}

data "terraform_remote_state" "base_state" {
  backend = "s3"
  config {
    bucket = "${var.application}-config"
    region = "${var.aws_region}"
    key = "${var.base_state_file}"
  }
}


resource "aws_s3_bucket_object" "object" {
    bucket = "${data.terraform_remote_state.init_state.terraform_bucket_id}"
    key = "init.sh"
    source = "init.sh"

}
