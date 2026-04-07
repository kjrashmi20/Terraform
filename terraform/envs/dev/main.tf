provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
}
module "ec2" {
  source = "../../modules/ec2"

  instance_type = "t2.micro"

  subnet_id = module.vpc.public_subnet_id
  vpc_id    = module.vpc.vpc_id
}
