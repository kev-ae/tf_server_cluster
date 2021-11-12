terraform {
  backend "s3" {
    key            = "stage/data-stores/mysql/terraform.tfstate"
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
  source = "github.com/kev-ae/tf_server_cluster_modules//data-stores/mysql?ref=v0.0.1"

  db_instance = "db.t2.micro"
  db_name     = "stagebackend"
  db_password = var.db_password
  db_username = "admin"
}