resource "aws_ecs_task_definition" "nginx-def" {
	family = "my-static-nginx"
	network_mode = "bridge"
	placement_constraints {
	 type = "memberOf"
	 expression = "attribute:ecs.instance-type == t2.micro"
	}
	container_definitions = "${file("container_def.json")}"
}

resource "aws_ecs_service" "nginx-service" {
	name = "nginx-webserver"
	task_definition = "${aws_ecs_task_definition.nginx-def.arn}"
	desired_count = 2
	launch_type = "EC2"
	cluster = "${aws_ecs_cluster.terraform_ecs_cluster.arn}"
	scheduling_strategy = "REPLICA"
	iam_role = "${aws_iam_role.ecs_service_role.arn}"
	load_balancer {
	 target_group_arn = "${aws_lb_target_group.ecs-tf-tg.arn}"
	 container_name = "nginx-webserver"
	 container_port = 80
	}
	depends_on = ["aws_lb_target_group.ecs-tf-tg"]
}
