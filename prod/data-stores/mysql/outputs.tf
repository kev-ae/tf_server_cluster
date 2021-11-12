output "address" {
  value = module.mysql.address
  description = "The address of the database"
}

output "port" {
  value = module.mysql.port
  description = "The port that the db is listening to"
}