resource "aws_vpc" "choria_test" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "choria_test"
  }
}

resource "aws_vpc_dhcp_options" "choria_test" {
  domain_name = "choria.example.net"
}

resource "aws_route53_record" "broker_srv" {
  zone_id = "${aws_route53_zone.choria_local.zone_id}"
  name    = "_x-puppet-mcollective._tcp.choria.example.net"
  type    = "SRV"
  ttl     = "600"
  records = [
    "10  0 4222  choria1.choria.example.net.",
    "10  0 4222  choria2.choria.example.net.",
    "10  0 4222  choria3.choria.example.net."
  ]
}
