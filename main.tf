module "vpc" {
  source               = "github.com/miguelh612/terraform-aws-vpc-AUY1105-mv?ref=v1.2.0"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_cidr  = var.private_subnet_cidr
}

module "ec2" {
  source                = "github.com/miguelh612/terraform-aws-ec2-AUY1105-mv?ref=v1.2.1"
  instance_name         = var.instance_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_id      = module.vpc.public_subnet_id
  public_subnet_2_id    = module.vpc.public_subnet_2_id
  alb_security_group_id = module.alb.alb_security_group_id
}

module "s3" {
  source = "github.com/miguelh612/terraform-aws-s3-AUY1105-mv?ref=v1.1.0"
}

module "alb" {
  source             = "github.com/miguelh612/terraform-aws-alb-AUY1105-mv?ref=v1.1.0"
  alb_name           = var.alb_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  ec2_instance_id    = module.ec2.ec2_instance_id
}
