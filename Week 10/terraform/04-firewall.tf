# The firewall rules 

# Allow port 22, SSH
resource "google_compute_firewall" "ssh" {
  name = "${var.vpc_name}-allow-ssh"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh-backend"]
}

# Ping Firewall Rule
resource "google_compute_firewall" "ping" {
  name = "${var.vpc_name}-allow-ping"
  network = google_compute_network.vpc.id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ping-backend"]
}

# Allow Health Check
resource "google_compute_firewall" "allow_hc" {
  name = "${var.vpc_name}-allow-health-check"

  allow {
    protocol = "tcp"
  }

  direction = "INGRESS"
  network = google_compute_network.vpc.id
  priority = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags = ["load-balanced-backend"]
}


resource "google_compute_firewall" "allow_proxy" {
  name = "${var.vpc_name}-allow-proxy"

  allow {
    ports = ["443"]
    protocol = "tcp"
  }

  allow {
    ports = ["80"]
    protocol = "tcp"
  }

  allow {
    ports = ["8080"]
    protocol = "tcp"
  }

  direction = "INGRESS"
  network = google_compute_network.vpc.id
  priority = 1000
  source_ranges = [google_compute_subnetwork.regional_proxy_subnet.ip_cidr_range]
  target_tags = ["load-balanced-backend"]
}