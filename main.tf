module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet1_cidr = var.subnet1_cidr
  subnet2_cidr = var.subnet2_cidr
  subnet3_cidr = var.subnet3_cidr
  env          = var.env
  providers = {
    aws = aws.virginia
  }
}
#module "autoscaling" {
#  source     = "./modules/autoscaling"
#  vpc_id1    = module.vpc.vpc_id
#  subnet1_id = module.vpc.subnet_1
#  subnet2_id = module.vpc.subnet_2 
#  env          = var.env
#  providers = {
#    aws = aws.virginia
#  }
#}

module "ecr" {
  source     = "./modules/ecr"
  env          = var.env
  providers = {
    aws = aws.virginia
  }
}

module "iamrole" {
  source     = "./modules/iamrole"
  env          = var.env
  providers = {
    aws = aws.virginia
  }
}

module "ecs-cluster" {
  source     = "./modules/ecs-cluster"
  env          = var.env
  providers = {
    aws = aws.virginia
  }
}
module "log" {
  source     = "./modules/log"
  env          = var.env
  providers = {
    aws = aws.virginia
  }
}

module "ecs-taskdef" {
  source    = "./modules/ecs-taskdef"
  env       = var.env
  imageurl  = module.ecr.aws-ecr
  taskrole  = module.iamrole.ecsTaskExecutionRole
  loggroup  = module.log.log-group
  providers = {
    aws = aws.virginia
  }
}

module "sg" {
  source    = "./modules/sg"
  env       = var.env
  vpc_id1    = module.vpc.vpc_id
  providers = {
    aws = aws.virginia
  }
}

module "ecs-service" {
  source    = "./modules/ecs-service"
  env       = var.env
  vpc_id1    = module.vpc.vpc_id
  family    = module.ecs-taskdef.familycount 
  revesion  = module.ecs-taskdef.revesion
 # main      = module.ecs-taskdef.main
  subnet1_id = module.vpc.subnet_1
  subnet3_id = module.vpc.subnet_3
  sgid      = module.sg.sg_id_alb
  service-sgid = module.sg.sg_id_service
  tgid      = module.lb.target_group
  listenerarn = module.lb.listener
  cluster-id  = module.ecs-cluster.aws-ecs-cluster
  #taskrole  = module.iamrole.ecsTaskExecutionRole
  #loggroup  = module.log.log-group
  providers = {
    aws = aws.virginia
  }
}

module "lb" {
  source = "./modules/lb"
  env       = var.env
  vpc_id1    = module.vpc.vpc_id
  subnet1_id = module.vpc.subnet_1
  subnet3_id = module.vpc.subnet_3
  alb-sg = module.sg.sg_id_alb
  providers = {
    aws = aws.virginia
  }
}

