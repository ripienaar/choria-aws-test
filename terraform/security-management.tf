resource "aws_security_group" "management" {
  vpc_id = "${aws_vpc.choria_test.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = "${var.choria_test_management_cidr}"
  }

  tags {
    Project = "choria_test"
  }
}
