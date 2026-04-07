output "instance_id" {
  value = aws_instance.app.id
}

output "public_ip" {
  value = aws_instance.app.public_ip
}

output "private_key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}
