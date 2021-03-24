output "vpc_name" {
      value = ["${aws_vpc.default.tags.Name}"]
}

output "vpc_id" {
      value = ["${aws_vpc.default.id}"]
}
