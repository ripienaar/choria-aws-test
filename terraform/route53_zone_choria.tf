resource "aws_route53_zone" "choria_local" {
  name = "choria.example.net"
  vpc_id = "${aws_vpc.choria_test.id}"
}
