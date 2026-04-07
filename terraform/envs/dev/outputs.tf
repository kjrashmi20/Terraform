output "instance_public_ip" {
  value = module.ec2.public_ip
}

output "private_key" {
  value     = module.ec2.private_key
  sensitive = true
}
