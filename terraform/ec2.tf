data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}
resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  tags = {
    Name = "Jenkins-Server"
  }
}
resource "aws_instance" "ansible" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.ansible_sg.id
  ]

  tags = {
    Name = "Ansible-Server"
  }
}