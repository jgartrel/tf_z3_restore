output "ssh_public_ip" {
  value = "${aws_instance.example.public_ip}"
}
output "ssh_private_key" {
  value = "${local_file.ssh_private_key.filename}"
}
