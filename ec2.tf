resource "aws_instance" "public_instance" {
  ami           = "ami-0e1bed4f06a3b463d" # Change to your desired AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet-demo-project.id
  associate_public_ip_address = true
  key_name = "demo-project"
  vpc_security_group_ids = [aws_security_group.allow_all.id]


# Provisioner to copy a local file to the EC2 instance
  provisioner "file" {
    source      = "./files/"         # Path to the local file on your machine
    destination = "/home/ubuntu/"  # Destination path on the EC2 instance
    connection {
      type        = "ssh"
      user        = "ubuntu"                  # SSH user (depends on your AMI, e.g., "ec2-user" for Amazon Linux)
      private_key = file("./demo-project.pem")  # Path to your private key for SSH authentication
      host        = aws_instance.public_instance.public_ip
    }
  }

  user_data = file("frontend.sh")
    
  

  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0e1bed4f06a3b463d" # Change to your desired AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private-subnet-demo-project.id
  key_name = "demo-project"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  user_data = file("my_sql.sh")

  tags = {
    Name = "private-instance"
  }
}