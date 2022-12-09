output "vpc_id" {
  value       = aws_vpc.default.id
  description = "VPC ID"
}

output "vpc_public_subnets_id" {
  value       = aws_subnet.public.*.id
  description = "VPC public subnet ID"
}

output "vpc_private_subnets_id" {
  value       = aws_subnet.private.*.id
  description = "VPC private subnet ID"
}

output "vpc_cidr_blocks" {
  value       = aws_vpc.default.*.cidr_block
  description = "VPC private subnet ID"
}
