resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "blonks-da-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_ssm_parameter" "private_key" {
  name  = "/secrets/key/${aws_key_pair.key_pair.key_name}"
  type  = "SecureString"
  value = tls_private_key.key.private_key_pem
}

resource "local_sensitive_file" "private_key_file" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/keys/${aws_key_pair.key_pair.key_name}.pem"
}
