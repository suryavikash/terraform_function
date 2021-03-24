resource "aws_instance" "servers" {
#    count = "${length(data.aws_subnet_ids.My_subnets.ids)}"
     count = 3
    ami = "${var.imagename}"
    #availability_zone = "${element(var.azs, count.index)}"
    instance_type = "${lookup(var.instance_size, var.environment)}"
    key_name = "${var.key_name}"
    subnet_id = "${element(aws_subnet.subnets.*.id,count.index)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true
    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y nginx unzip
                sudo service nginx start
                echo "<h1> Deployed via Terraform </h1>" | "sudo tee /usr/share/nginx/html"
    EOF
    tags = {
        Name = "Terraform-Server-${count.index+1}"
        Env = "test"
        Owner = "Surya"
    }
}
