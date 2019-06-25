output "dns_name_alb" {
	value = "${aws_lb.tf-ecs-alb.dns_name}"
}

output "web_server_ip" {
	value = "${aws_eip.tf_lab_eip.public_ip}"	
}
