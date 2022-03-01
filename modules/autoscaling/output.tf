output "sg_id" {
  value = aws_security_group.securitygroup1.id
}

output "asg_lc_id" {
  value = aws_launch_configuration.mclouds_as_conf.id
}
output "asg_id" {
  value = aws_autoscaling_group.bar.id
}
