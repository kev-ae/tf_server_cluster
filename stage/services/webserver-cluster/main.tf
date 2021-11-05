terraform {
  backend "s3" {
    key = "stage/services/webserver-cluster/terraform.tfstate"
    bucket = "uartf-backend"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "uartf-locks"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
    source = "../../modules/services/webserver-cluster"

    cluster_name = "webservers-stage"
    db_remote_state_bucket = "uartf-backend"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
}