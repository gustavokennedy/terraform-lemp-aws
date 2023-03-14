output "instance_public_ip" {
  description = "Endereço de IP da instância:"
  value       = aws_lightsail_instance.instance.public_ip_address
}
