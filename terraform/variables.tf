variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "ssh_key" {
  description = "AWS secret access key"
}

variable "puppetserver-version" {
  description = "Version of Puppet Server to install"
  default     = "5.3.1"
}

variable "puppetagent-version" {
  description = "Version of Puppet Agent to install"
  default     = "5.5.1"
}

variable "puppetdb-version" {
  description = "Version of PuppetDB to install"
  default     = "5.2.2"
}

variable "region" {
  description = "AWS region to host your networks"
  default     = "eu-central-1"
}

variable "avail_zone" {
  description = "AWS availability zone to host your network"
  default     = "eu-central-1a"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}

variable "choria_test_subnet_cidr" {
  description = "CIDR for public subnet in availability zone A"
  default     = "10.128.1.0/24"
}

variable "choria_test_management_cidr" {
  description = "CIDRs allowed to SSH into the network"
  default = ["139.162.163.118/32", "84.255.40.82/32"]
}


/* https://wiki.centos.org/Cloud/AWS */
variable "centos_amis" {
  description = "AMI for CentOS 7 based instances"
  default = {
    eu-central-1 = "ami-337be65c"
  }
}

/* https://cloud-images.ubuntu.com/locator/ec2/ */
variable "ubuntu_lts_amis" {
  description = "AMI for Ubuntu Xenial based instances"
  default = {
    eu-central-1 = "ami-7c412f13"
  }
}

/* https://wiki.debian.org/Cloud/AmazonEC2Image */
variable "debian_stretch_amis" {
  description = "AMI for Debian Stretch based instances"
  default = {
    eu-central-1 = "ami-6ef69f01"
  }
}

variable "arch_amis" {
  description = "AMI for ArchLinux based instances"
  default = {
    eu-central-1 = "ami-e56e3f0e"
  }
}
