resource "aws_vpc" "tf-lab" {
	cidr_block = "${var.main_cidr}"
	tags = {
	  Name = "main-tf VPC"	
	}
}

resource "aws_subnet" "private_tf_subnet" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	cidr_block = "${var.private_cidr}"
	
	tags = {
	  Name = "Priavte main-tf subnet"
	}
}

resource "aws_subnet" "public_tf_subnet" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	cidr_block = "${var.public_cidr}"
	availability_zone = "${var.azs[0]}"
	tags = {
	 Name = "Public main-tf subnet 01"
	}
}

resource "aws_subnet" "public_tf_subnet_2" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	cidr_block = "${var.public_subnet_02}"
	availability_zone = "${var.azs[1]}"
	tags = {
	 Name = "Public sunet 02"
	}
}

resource "aws_eip" "tf_lab_eip" {
	vpc = true
	public_ipv4_pool = "amazon"
}

resource "aws_nat_gateway" "tf_lab_ngw" {
	allocation_id = "${aws_eip.tf_lab_eip.id}"
	subnet_id = "${aws_subnet.public_tf_subnet.id}"

	tags = {
	  Name = "tf-lab NGW"
	}
}

resource "aws_internet_gateway" "tf_lab_igw" {
  vpc_id = "${aws_vpc.tf-lab.id}"

  tags = {
    Name = "tf-lab IGW"
  }
}

resource "aws_route_table" "tf_private_rt" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	route {
	  cidr_block = "0.0.0.0/0"
	  nat_gateway_id = "${aws_nat_gateway.tf_lab_ngw.id}"
	}

	tags = {
	  Name  = "tf-lab private route table"
	}
}

resource "aws_route_table" "tf_public_rt" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	route {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = "${aws_internet_gateway.tf_lab_igw.id}"
	}
	tags = {
	  Name = "tf_lab public route table"
	}
}


resource "aws_route_table_association" "tf_private_rta" {
	subnet_id = "${aws_subnet.private_tf_subnet.id}"
	route_table_id = "${aws_route_table.tf_private_rt.id}"
}

resource "aws_route_table_association" "tf_public_rta" {
        subnet_id = "${aws_subnet.public_tf_subnet.id}"
        route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_route_table_association" "tf_public_rta_02" {
        subnet_id = "${aws_subnet.public_tf_subnet_2.id}"
        route_table_id = "${aws_route_table.tf_public_rt.id}"
}


resource "aws_security_group" "ssh_access" {
	vpc_id = "${aws_vpc.tf-lab.id}"
	name = "tf_lab ssh access"
	description = "this is to allow only SSH access"

	egress {
	 from_port = 0
	 to_port = 0
	 protocol = "-1"
	 cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
	 from_port = 0
	 to_port = 22
	 protocol = "tcp"
	 cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
	 Name = "allow ssh access"
	}
}
