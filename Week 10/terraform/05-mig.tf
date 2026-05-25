# Managed Instance Groups

# Compute Zones Data Source
data "google_compute_zones" "available" {
  status = "UP"
}

# Instance Template for the MIG
resource "google_compute_instance_template" "app" {
  name = "${var.mig_name}-template"
  description = "Instance template for the MIG"
  region = var.region
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-12"
    boot = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["load-balanced-backend", "ssh-backend", "ping-backend", "web-traffic-backend"]

  metadata_startup_script = file("${path.module}/startup-script.sh")
}

# Managed Instance Group
resource "google_compute_region_instance_group_manager" "app" {
  depends_on = [google_compute_router_nat.iowa]
  name = var.mig_name
  region = var.region
  base_instance_name = "${var.mig_name}-instance"

  distribution_policy_zones = data.google_compute_zones.available.names

  version {
    instance_template = google_compute_instance_template.app.id
  }

  named_port {
    name = "webserver"
    port = 80
  }

  auto_healing_policies {
    health_check = google_compute_health_check.app.id
    initial_delay_sec = 300
  }
}

# Health Check
resource "google_compute_health_check" "app" {
  name = "${var.mig_name}-health-check"
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 3

  http_health_check {
    request_path = "/index.html"
    port = 80
  }
}

# Autoscaler for the MIG
resource "google_compute_region_autoscaler" "app" {
  name = "${var.mig_name}-autoscaler"
  target = google_compute_region_instance_group_manager.app.id

  autoscaling_policy {
    max_replicas = var.mig_max_instances
    min_replicas = var.mig_min_instances
    cpu_utilization {
      target = 0.5
    }
  }
}