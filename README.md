# AUY-1105 - EP2, Miguel Villagra

## Objetivo

Este directorio muestra cómo consumir todos los módulos del proyecto para levantar una arquitectura completa: VPC, EC2, S3 y ALB.

## Uso

El módulo principal sirve como punto de integración entre los componentes. Se usa para orquestar la red, el servidor web, el balanceador y el bucket S3 desde sus repositorios versionados.

```hcl
module "vpc" {
  source = "github.com/miguelh612/terraform-aws-vpc-AUY1105-mv?ref=v1.0.0"
}

module "ec2" {
  source                = "github.com/miguelh612/terraform-aws-ec2-AUY1105-mv?ref=v1.0.2"
  vpc_id                = module.vpc.vpc_id
  public_subnet_id      = module.vpc.public_subnet_id
  public_subnet_2_id    = module.vpc.public_subnet_2_id
  alb_security_group_id = module.alb.alb_security_group_id
}

module "s3" {
  source = "github.com/miguelh612/terraform-aws-s3-AUY1105-mv?ref=v1.0.1"
}

module "alb" {
  source             = "github.com/miguelh612/terraform-aws-alb-AUY1105-mv?ref=v1.0.2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  ec2_instance_id    = module.ec2.ec2_instance_id
}
```

Después de aplicar, puedes revisar el DNS del ALB y la IP pública de la EC2 para validar el entorno.
