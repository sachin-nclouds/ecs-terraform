output "vpc_id" {
  value = module.vpc.vpc_id
}


output "subnet_1" {
  value = module.vpc.subnet_1
}

output "subnet_2" {
  value = module.vpc.subnet_2
}
output "subnet_3" {
  value = module.vpc.subnet_3
}

output "gw" {
  value = module.vpc.gw
}
output "nat-gw" {
  value = module.vpc.nat-gw
}
output "aws-ecr" {
  value = module.ecr.aws-ecr
}
output "ecsTaskExecutionRole" {
  value = module.iamrole.ecsTaskExecutionRole
}
output "aws-ecs-cluster" {
  value = module.ecs-cluster.aws-ecs-cluster
}
output "log-group" {
  value = module.log.log-group
}
output "alb-dns" {
  value = module.lb.alb_dns 
}
