output "vpc_name" {
  description = "Name of the custom VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "Name of the subnet created within the custom VPC"
  value       = google_compute_subnetwork.subnet.name
}

output "load_balancer_ip" {
  description = "Reserved external IP of the load balancer — use this to test in a browser"
  value       = google_compute_global_address.lb.address
}