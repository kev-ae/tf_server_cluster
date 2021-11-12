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
  source = "github.com/kev-ae/tf_server_cluster_modules//services/webserver-cluster?ref=v0.0.1"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "uartf-backend"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name  = "scale-out-during-business-hours"
  autoscaling_group_name = module.webserver_cluster.asg_name
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  autoscaling_group_name = module.webserver_cluster.asg_name
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
}