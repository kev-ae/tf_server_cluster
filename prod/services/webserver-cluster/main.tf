terraform {
  backend "s3" {
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    bucket         = "uartf-backend"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "uartf-locks"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../modules/serives/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "uartf-backend"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}