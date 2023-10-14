resource "aws_eip" "lb" {
  domain   = "vpc"
}

output "eip" {
  value = aws_eip.lb.public_ip
}
