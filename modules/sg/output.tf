
output "sg_id_alb" {
  value = aws_security_group.load_balancer_security_group.id
}

output "sg_id_service" {
  value = aws_security_group.service_security_group.id
}
