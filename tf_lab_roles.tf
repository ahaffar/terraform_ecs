resource "aws_iam_service_linked_role" "ecs_asg_srv_role" {
	aws_service_name = "autoscaling.amazonaws.com"
	custom_suffix = "${var.ecs_cluster_name}"
}

data "aws_iam_policy_document" "ecs_asg_doc"{
	statement {
	 sid = "asgPolicyDocument"
	 actions = ["sts:AssumeRole"]
	 effect = "Allow"
	 principals {
	  type = "Service"
	  identifiers = ["autoscaling.amazonaws.com"]
        	}
	}
}



resource "aws_iam_role" "ecs_agent_role" {
	name = "ecs-instance_role"
	path = "/"
	assume_role_policy = "${data.aws_iam_policy_document.ecs_agent_doc.json}"
	
}

data "aws_iam_policy_document" "ecs_agent_doc" {
	statement {
	 sid = "ecsAgentPolicyDocument"
	 effect = "Allow"
	 actions = ["sts:AssumeRole"]
	 principals  {
	  type = "Service"
	  identifiers  = ["ec2.amazonaws.com"]	
		} 
	}
}

resource "aws_iam_role_policy_attachment" "ecs_agent_attch" {
	role = "${aws_iam_role.ecs_agent_role.name}"
	policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ecs_service_role" {
	name = "ecs_service_role"
	path= "/"
	assume_role_policy = "${data.aws_iam_policy_document.ecs_service_doc.json}"
}

data "aws_iam_policy_document" "ecs_service_doc" {
	statement {
	 sid = "ecsServiceRole"
	 effect = "Allow"
	 actions = ["sts:AssumeRole"]
	 principals {
	   type = "Service"
	   identifiers = ["ecs.amazonaws.com"]
	 }
	}
}

resource "aws_iam_role_policy_attachment" "ecs_service_attach" {
	role = "${aws_iam_role.ecs_service_role.name}"
	policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

#resource "aws_iam_instance_profile" "tf_lab_profile" {
#	name = "ECS Agent Profile"
#	role = "${aws_iam_role.ecs_agent_role.name}"
#}
