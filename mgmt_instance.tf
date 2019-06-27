data "aws_ami" "amzn_linux_2" {
	most_recent = true
	owners = ["amazon"]
	filter {
	 name = "name"
	 values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
	}
	filter {
	 name = "root-device-type"
	 values = ["ebs"]
	}
	filter {
	 name = "virtualization-type"
	 values = ["hvm"]
	}
}

output "mgmt_server_info" {
	value = "${data.aws_ami.amzn_linux_2.id}"
}

resource "aws_instance" "mgmt_srv" {
	ami = "${data.aws_ami.amzn_linux_2.id}"
	availability_zone = "${data.aws_availability_zones.azs.names[0]}"
	instance_type = "${var.aws_instance_type}"
	key_name = "${var.ec2_key_pair}"
	subnet_id = "${aws_subnet.public_tf_subnet.id}"
	associate_public_ip_address = true
	vpc_security_group_ids = ["${aws_security_group.ssh_access.id}"]
	connection {
         type = "ssh"
	 host = self.public_ip
         user = "ec2-user"
         private_key = file("/home/ec2-user/alhaffar-aws.pem")
                }

	provisioner file {
	 source = "/home/ec2-user/alhaffar-aws.pem"
	 destination = "/home/ec2-user/alhaffar-aws.pem"
		}
	tags = {
	Name ="terraform managment host"
	}
}

output "mgmt_instance_ip" {
	value = "${aws_instance.mgmt_srv.public_ip}"
}
