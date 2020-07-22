provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"

  username            = "admin"

  name                = "example_database_stage"
  skip_final_snapshot = true

  password            = var.db_password
}
    
terraform {
backend "s3" {
# Replace this with your bucket name!
    bucket = "terraform-up-and-running-state-pravesh"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
# Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
    }   
}
