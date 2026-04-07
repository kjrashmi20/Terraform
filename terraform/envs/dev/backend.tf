terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-0704"
    key    = "dev/terraform.tfstate"
    region = "us-east-2"
  }
}
