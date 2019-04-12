provider "aws" {
  region                  = "us-west-2"
}

variable "project" {
  default = "tf_z3_restore"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.project}"
  public_key = "${tls_private_key.ssh_key.public_key_openssh}"
}

resource "aws_instance" "example" {
  ami           = "ami-005bdb005fb00e791"
  subnet_id     = "subnet-03652bcc3f3409028"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  user_data          = "${file("cloudinit.conf")}"
  tags = {
    Name = "Example Instance1"
  }
}

resource "aws_ebs_volume" "example-volume" {
  availability_zone = "${aws_instance.example.availability_zone}"
#  type              = "sc1"
  type              = "gp2"
  size              = 32
}

resource "aws_volume_attachment" "example-volume-attachment" {
  device_name = "/dev/xvdb"
  instance_id = "${aws_instance.example.id}"
  volume_id   = "${aws_ebs_volume.example-volume.id}"
}

resource "local_file" "ssh_private_key" {
  sensitive_content = "${tls_private_key.ssh_key.private_key_pem}"
  filename = "${path.module}/${aws_key_pair.generated_key.key_name}.priv"
  provisioner "local-exec" {
    command = "chmod 600 ${path.module}/${aws_key_pair.generated_key.key_name}.priv"
}
}
