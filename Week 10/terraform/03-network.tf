# The network resource made available for the VPC
# and Subnet
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet for VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnet_cidr
}

# Regional Subnet for Proxy
resource "google_compute_subnetwork" "regional_proxy_subnet" {
  name          = "${var.vpc_name}-regional-proxy-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.100.0.0/23"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

# Route for VPC
resource "google_compute_router" "main" {
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}

