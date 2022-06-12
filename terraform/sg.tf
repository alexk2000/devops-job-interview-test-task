resource "aws_security_group" "test_task" {
  name        = "test-task"
  description = "allow ssh, http"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_task.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_task.id
  description       = "allow ssh"
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_task.id
  description       = "allow http"
}
