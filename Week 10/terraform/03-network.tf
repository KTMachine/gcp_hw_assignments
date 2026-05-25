# The network resource made available for the VPC
# and Subnet

# VPC Network
resource "google_compute_network" "vpc" {
  name                            = var.vpc_name
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

}

# Subnet for VPC
resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.vpc_name}-subnet"
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
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
resource "google_compute_router" "iowa" {
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.id
}


# Nat for VPC
resource "google_compute_router_nat" "iowa" {
  name = "${var.vpc_name}-nat"
  router = google_compute_router.iowa.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.iowa.self_link]

  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Compute Address for NAT
resource "google_compute_address" "iowa" {
  name = "${var.vpc_name}-nat-iowa-ip"
  region = var.region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}