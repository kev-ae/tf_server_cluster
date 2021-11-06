terraform {
  backend "s3" {
    key            = "prod/data-stores/mysql/terraform.tfstate"
    bucket         = "uartf-backend"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "uartf-locks"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../modules/data-stores/mysql"

  db_instance = "db.t2.micro"
  db_name     = "prod-backend"
  db_password = var.db_password
  db_username = "admin"
}