resource "aws_launch_configuration" "ec2_config" {
	image_id = "${lookup(var.instance_ami, var.aws_region)}"
	instance_type = "${var.aws_instance_type}"
	key_name = "${var.ec2_key_pair}"
	security_groups = ["${aws_security_group.alb_access.id}"]
	user_data = "${data.template_file.ecs_cluster_name.rendered}"
	iam_instance_profile = "${aws_iam_instance_profile.test_profile.id}"
	
	lifecycle {
	 create_before_destroy = true
	}
}

data "template_file" "ecs_cluster_name" {
	template = "${file("container_agent.tpl")}"
	vars = {
	 cluster_name = "${var.ecs_cluster_name}"
	}
}


resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.ecs_agent_role.name}"
}
