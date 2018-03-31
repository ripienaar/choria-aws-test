resource "template_file" "debian_broker_init" {
  template = "${file("cloud-init/debian-common.txt")}"
  vars {
    puppetagent = "${var.puppetagent-version}"
    role = "network_broker"
    hostname = "debian9.choria.example.net"
  }
}

resource "aws_instance" "debian_broker" {
  count = 1
  ami = "${lookup(var.debian_stretch_amis, var.region)}"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.choria_test.id}"
  vpc_security_group_ids = ["${aws_security_group.internal.id}", "${aws_security_group.management.id}"]
  source_dest_check = false
  user_data = "${template_file.debian_broker_init.rendered}"
  key_name = "${var.ssh_key}"
  root_block_device {
    volume_type = "standard"
    volume_size = 8
    delete_on_termination = true
  }
  tags = {
    Project = "choria_test"
  }
}

output "debian_broker" {
  value = "${aws_instance.debian_broker.public_dns}"
}

resource "aws_route53_record" "choria3" {
  zone_id = "${aws_route53_zone.choria_local.zone_id}"
  name    = "debian9.choria.example.net"
  type    = "A"
  ttl     = "600"
  records = ["${aws_instance.debian_broker.private_ip}"]
}
