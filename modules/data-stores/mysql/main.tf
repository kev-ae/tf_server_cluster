terraform {
  backend "s3" {
    bucket         = "uartf-backend"
    region         = "us-east-2"
    key            = "modules/data-stores/mysql/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "uartf-locks"
  }
}
resource "aws_db_instance" "database" {
  identifier_prefix = "terraform-up-and-running"
  allocated_storage = 10
  engine            = "mysql"
  instance_class    = var.db_instance
  name              = var.db_name
  username          = var.db_username
  password          = var.db_password
}