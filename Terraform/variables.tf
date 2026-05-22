output "public_ip" {

  value = aws_instance.monitoring_server.public_ip
}

output "public_dns" {

  value = aws_instance.monitoring_server.public_dns
}

output "instance_id" {

  value = aws_instance.monitoring_server.id
}

output "ssh_command" {

  value = "ssh -i terra.pem ubuntu@${aws_instance.monitoring_server.public_ip}"
}

