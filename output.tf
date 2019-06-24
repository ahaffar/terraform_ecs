output "dns_name_alb" {
	value = "${aws_lb.tf-ecs-alb.dns_name}"
}
