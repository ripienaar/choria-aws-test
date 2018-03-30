resource "aws_internet_gateway" "choria_test" {
  vpc_id = "${aws_vpc.choria_test.id}"

  tags {
    Project = "choria_test"
  }
}
