variable "ecs_cluster_name" {
	default = "terraform_ecs"
}
variable "aws_instance_type" {
	default = "t2.micro"
}
variable "aws_access_key" {
	default = ""
}

variable "aws_secret_key" {
	default = ""
}

variable ec2_key_pair {
	default = "alhaffar-aws"
}

variable "aws_region" {
	default = "us-east-2"
}

variable "instance_ami" {
	type = "map"
	default = {
		"us-east-2" = "ami-0c41b421bf4efab32"
		"us-east-1" = "ami-0f812849f5bc97db5"
		"us-west-1" = "ami-09927f2913ee48e79"
		"us-west-2" = "ami-096cf539543dfbe40"
		"ap-east-1" = "ami-061b08c2b98d7360c"
		"eu-west-1" = "ami-0d9430336a60e81c5"
		"eu-west-2" = "ami-0bcdb1fbd79cc1a6f"
		"eu-west-3" = "ami-0f2070b01db3ba354"
	}
}

variable "main_cidr" {
	type = "string"
	default = "172.16.238.0/24"
}

variable "private_cidr" {
	type = "string"
	default = "172.16.238.0/26"
}

variable "public_cidr" {
	type = "string"
	default = "172.16.238.64/26"
}
