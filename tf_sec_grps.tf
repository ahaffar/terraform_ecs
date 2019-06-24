resource "aws_security_group" "priv_access" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	name = "tf_lab security groups"
	
	egress  {
	 cidr_blocks = ["0.0.0.0/0"]
	 to_port = 0
	 from_port = 0
	 protocol = "-1"
	}
	
	ingress  {
	 cidr_blocks = ["0.0.0.0/0"]
	 to_port = "22"
	 protocol = "tcp"
	 from_port  = 0
	}

	ingress {
	 cidr_blocks = ["0.0.0.0/0"]
	 to_port = "80"
	 protocol= "tcp"
	 from_port = 0
	}

}
