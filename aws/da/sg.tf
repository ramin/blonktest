resource "aws_security_group" "node" {
  name        = "celestia-full-node-sg"
  description = "Security group for Celestia full node"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node.id
}

resource "aws_security_group_rule" "node-ingress-rpc" {
  type              = "ingress"
  from_port         = 26657
  to_port           = 26657
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node.id
}

resource "aws_security_group_rule" "node-ingress-p2p" {
  type              = "ingress"
  from_port         = 26656
  to_port           = 26656
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node.id
}


resource "aws_security_group" "ssh" {
  name        = "ssh-sg"
  description = "Security group for SSH access"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh.id
}


