resource "aws_vpc" "services_vpc" {
  cidr_block = var.SERVICES_VPC_CIDR
  instance_tenancy = "default"

  tags = {
    Name = "Services VPC"
  }
}