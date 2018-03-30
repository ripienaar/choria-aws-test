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
  default     = "5.3.0"
}

variable "puppetagent-version" {
  description = "Version of Puppet Agent to install"
  default     = "5.4.0"
}

variable "puppetdb-version" {
  description = "Version of PuppetDB to install"
  default     = "5.1.4"
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
  description = "Base AMI to launch the instances with"
  default = {
    eu-central-1 = "ami-337be65c"
  }
}
