# Backend for the Load Balancer
# Regional Health Check for the Load Balancer
resource "google_compute_health_check" "lb" {
  name = "${var.lb_name}-health-check"

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/index.html"
  }
}


# Regional Backend Service for the Load Balancer
resource "google_compute_backend_service" "lb" {
  name = "${var.lb_name}-backend-service"

  protocol      = "HTTP"
  health_checks = [google_compute_health_check.lb.self_link]

  port_name = "webserver"

  backend {
    group           = google_compute_region_instance_group_manager.main.instance_group
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
  }
}