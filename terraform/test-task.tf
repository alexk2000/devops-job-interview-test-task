resource "aws_instance" "test_task" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.test_task.id]
  tags = {
    Name = "test-task"
  }  

  # Wait for ssh up & running
  provisioner "local-exec" {
    command     = <<-EOT
    ANSIBLE_HOST_KEY_CHECKING=False \
    ansible -i 'localhost,' all \
    -c local \
    -u {var.ssh_user} --private-key=${var.ssh_key_path} \
    -m wait_for -a 'host=${self.public_ip} port=22 delay=5' \
    EOT
    working_dir = var.ansible_playbooks_path
  }

  # Install K3S/FluxCD 
  provisioner "local-exec" {
    command     = <<-EOT
    ANSIBLE_HOST_KEY_CHECKING=False \
    ansible-playbook -i '${self.public_ip},' \
    -u ${var.ssh_user} --private-key=${var.ssh_key_path} \
    ${var.playbook}
    EOT
    working_dir = var.ansible_playbooks_path
  }
}
