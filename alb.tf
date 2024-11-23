resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = [
    aws_subnet.public.id,
    aws_subnet.public_b.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "main-lb"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "main-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "main-tg"
  }
}

resource "aws_lb_target_group_attachment" "main_a" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.main_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "main_b" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.main_b.id
  port             = 80
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
