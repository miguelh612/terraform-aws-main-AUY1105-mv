module "vpc" {
  source = "github.com/miguelh612/terraform-aws-vpc-AUY1105-mv?ref=v1.0.0"
}

module "ec2" {
  source = "github.com/miguelh612/terraform-aws-ec2-AUY1105-mv?ref=v1.0.2"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  alb_security_group_id = module.alb.alb_security_group_id
}

module "s3" {
  source = "github.com/miguelh612/terraform-aws-s3-AUY1105-mv?ref=v1.0.1"
}

module "alb" {
  source = "github.com/miguelh612/terraform-aws-alb-AUY1105-mv?ref=v1.0.2"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  ec2_instance_id = module.ec2.ec2_instance_id
}