data "aws_subnet_ids" "My_subnets" {
  vpc_id = "${aws_vpc.default.id}"
}


resource "aws_instance" "servers" {
#    count = "${length(data.aws_subnet_ids.My_subnets.ids)}"
     count = 3
    ami = "${lookup(var.amis, var.aws_region, us-east-1a)}"
    #availability_zone = "${element(var.azs, count.index)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    subnet_id = "${element(tolist(data.aws_subnet_ids.My_subnets.ids), count.index+2)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true
    tags = {
        Name = "Terraform-Server-${count.index+1}"
        Env = "test"
        Owner = "Surya"
    }
}
