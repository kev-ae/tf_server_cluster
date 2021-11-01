terraform {
    backend "s3" {
        bucket = "uartf-backend"
        region = "us-east-2"
        key = "stage/data-stores/mysql/terraform.tfstate"
        encrypt = true
        dynamodb_table = "uartf-locks"
    }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_db_instance" "database" {
    identifier_prefix = "terraform-up-and-running"
    allocated_storage = 10
    engine = "mysql"
    instance_class = "db.t2.micro"
    name = "example_database"
    username = "admin"
    password = var.db_password
}