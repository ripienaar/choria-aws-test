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
    "10 0 4222 centos7.choria.example.net.",
    "10 0 4222 debian9.choria.example.net.",
    "10 0 4222 ubuntu16.choria.example.net."
  ]
}

resource "aws_route53_record" "federation_srv" {
  zone_id = "${aws_route53_zone.choria_local.zone_id}"
  name    = "_mcollective-federation_server._tcp.choria.example.net"
  type    = "SRV"
  ttl     = "600"
  records = [
    "10 0 4222 puppet.choria.example.net.",
  ]
}
