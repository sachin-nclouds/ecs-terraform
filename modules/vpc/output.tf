output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_1" {
  value = aws_subnet.subnet1.id
}

output "subnet_2" {
  value = aws_subnet.subnet2.id
}
output "subnet_3" {
  value = aws_subnet.subnet3.id
}

output "gw" {
  value = aws_internet_gateway.gw.id
}
output "nat-gw" {
  value = aws_nat_gateway.nat-gw.id
}
