variable "server_port" {
  description = "The port of the web server"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all the cluster resource"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in s3"
  type        = string
}