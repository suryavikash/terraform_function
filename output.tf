output "vpc_name" {
      value = ["${aws_vpc.default.tags.name}"]
}

output "vpc_id" {
      value = ["${aws_vpc.default.id}"]
}