resource "aws_ecs_cluster" "terraform_ecs_cluster" {
	name = "${var.ecs_cluster_name}"
}

resource "aws_autoscaling_group" "ecs_tf_scaling_group" {
	name = "auto scaling group for terraform ecs cluster"
	max_size = 4
	min_size = 1
	health_check_type = "EC2"
	desired_capacity = 1
	termination_policies = ["OldestInstance"]
	vpc_zone_identifier = ["${aws_subnet.private_tf_subnet.id}"]
	launch_configuration = "${aws_launch_configuration.ec2_config.name}"
	#service_linked_role_arn = "${aws_iam_service_linked_role.ecs_asg_srv_role.arn}"
	service_linked_role_arn = "arn:aws:iam::070775348724:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
}
