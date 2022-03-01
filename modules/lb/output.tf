

output "alb_dns" {
  value = aws_alb.application_load_balancer.dns_name
}

output "target_group" {
  value = aws_lb_target_group.target_group.arn
}
output "listener" {
  value = aws_lb_listener.listener.arn
}