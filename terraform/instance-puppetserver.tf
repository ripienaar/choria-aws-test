resource "template_file" "puppetserver_init" {
  template = "${file("cloud-init/puppetserver.txt")}"
  vars {
    puppetagent = "${var.puppetagent-version}"
    puppetserver = "${var.puppetserver-version}"
    puppetdb = "${var.puppetdb-version}"
  }
}

resource "aws_instance" "puppetserver" {
  count = 1
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "t2.large"
  subnet_id = "${aws_subnet.choria_test.id}"
  vpc_security_group_ids = ["${aws_security_group.internal.id}", "${aws_security_group.management.id}"]
  source_dest_check = false
  user_data = "${template_file.puppetserver_init.rendered}"
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

output "puppetserver" {
  value = "${aws_instance.puppetserver.public_dns}"
}
