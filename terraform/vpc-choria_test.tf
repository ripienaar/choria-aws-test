resource "aws_vpc" "choria_test" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "choria_test"
  }
}
