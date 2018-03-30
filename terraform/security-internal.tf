resource "aws_security_group" "internal" {
  name = "internal"
  vpc_id = "${aws_vpc.choria_test.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Project = "choria_test"
  }
}
