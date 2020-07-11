provider "aws" {
    region = "us-east-2" 
}

variable "server_port" {
    description =  "The port the server will use for HTTP requests"
    type        = number
    default     = 8080
}


resource "aws_instance" "pravesh_test" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instane.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF 

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instane" {
    name = "terraform-example-instance"

    ingress {
        from_port  = var.server_port
        to_port    = var.server_port
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

}

output "pubic_ip" {
    value = aws_instance.pravesh_test.public_ip
    description = "The public ip address of the web server"
}