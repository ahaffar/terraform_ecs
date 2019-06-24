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
	 from_port  = 22
	}

	ingress {
	 from_port = 32760
	 to_port = 32799
	 protocol = "tcp"
	 security_groups = ["${aws_security_group.alb_sec_grp.id}"]
	}


}

resource "aws_security_group" "alb_sec_grp" {
	name = "ALB SED GRP"
	vpc_id = "${aws_vpc.tf-lab.id}"
	
	egress {
	 cidr_blocks = ["0.0.0.0/0"]
	 from_port = 0
	 to_port = 0 
	 protocol = "-1"
	}
	
	ingress {
	 to_port = 80
	 from_port = 80 
	 protocol = "tcp"
	 cidr_blocks =  ["0.0.0.0/0"]
	}
	
	ingress {
         to_port = 443
	 from_port = 443
         protocol = "tcp"
	 cidr_blocks = ["0.0.0.0/0"]
        }
}


