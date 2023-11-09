terraform {
    backend "s3" {
        bucket = "tf-state-osmcha"
        key = "terraform/state/prod/terraform.tfstate"
        region = "us-east-1"
    }
}