output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The dns name for the load balancer"
}