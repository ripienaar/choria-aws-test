resource "aws_subnet" "choria_test" {
  vpc_id            = "${aws_vpc.choria_test.id}"
  cidr_block        = "${var.choria_test_subnet_cidr}"
  availability_zone = "${var.avail_zone}"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.choria_test"]
  tags {
    Project = "choria_test"
  }
}

resource "aws_route_table_association" "default" {
  subnet_id = "${aws_subnet.choria_test.id}"
  route_table_id = "${aws_route_table.default.id}"
}
