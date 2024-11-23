resource "aws_instance" "main_a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = "shoot"

  tags = {
    Name = "shoot-a"
  }
}

resource "aws_instance" "main_b" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_b.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = "shoot"

  tags = {
    Name = "shoot-b"
  }
}
