# key 'main' created manually
variable "key" {
  type    = string
  default = "main"
}

# Amazon Linux 2 AMI
variable "ami" {
  type    = string
  default = "ami-0c115dbd34c69a004"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_user" {
  type    = string
  default = "ec2-user"
}

variable "ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "ansible_playbooks_path" {
  type    = string
  default = "../ansible"
}

variable "playbook" {
  type    = string
  default = "test-task.yaml"
}
