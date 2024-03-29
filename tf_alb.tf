resource "aws_lb_target_group" "ecs-tf-tg" {
	name = "terrform-webserver-ecs-tg"
	port = 80
	protocol = "HTTP"
	vpc_id = "${aws_vpc.tf-lab.id}"
	target_type = "instance"
	health_check  {
	 enabled = true
	 path = "/"
	 port = "traffic-port"
	 protocol = "HTTP"
	}
	depends_on = ["aws_lb.tf-ecs-alb"]
}

resource "aws_lb" "tf-ecs-alb" {
	name = "ECS-ApplicationLoadBalancer"
	internal = false
	load_balancer_type = "application"
	security_groups = ["${aws_security_group.alb_sec_grp.id}"]
	subnets = ["${aws_subnet.public_tf_subnet.id}", "${aws_subnet.public_tf_subnet_2.id}"]
	ip_address_type = "ipv4"
}

resource "aws_lb_listener" "tf-ecs-alb-lsn" {
	load_balancer_arn = "${aws_lb.tf-ecs-alb.arn}"
	port = "80"
	protocol = "HTTP"
	default_action  {
	 type = "forward"
	 target_group_arn = "${aws_lb_target_group.ecs-tf-tg.arn}"
	}
}

resource "aws_lb_target_group" "flask-app" {
	name = "flask-app-tg"
	port = 5000
	protocol = "HTTP"
	vpc_id = "${aws_vpc.tf-lab.id}"
	target_type = "instance"
	health_check {
	 enabled = true
	 path = "/"
	 port = "traffic-port"
	}
	depends_on = ["aws_lb.tf-ecs-alb"]
}

resource "aws_lb_listener" "flask-app-lsn" {
	load_balancer_arn = "${aws_lb.tf-ecs-alb.arn}"
	port = 8080
	protocol = "HTTP"
	default_action {
	 type = "forward"
	 target_group_arn = "${aws_lb_target_group.flask-app.arn}"
	}

}
