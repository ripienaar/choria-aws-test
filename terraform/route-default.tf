resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.choria_test.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.choria_test.id}"
  }
  tags {
    Project = "choria_test"
  }
}
