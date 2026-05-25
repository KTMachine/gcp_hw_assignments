
resource "google_compute_global_address" "lb" {
  name = "${var.lb_name}-ip"
  
}


resource "google_compute_global_forwarding_rule" "lb" {
  name = "${var.lb_name}-forwarding-rule"

  target     = google_compute_target_http_proxy.application_lb.self_link
  port_range = "80"

  ip_protocol           = "TCP"
  ip_address            = google_compute_global_address.lb.address
  load_balancing_scheme = "EXTERNAL"
}


resource "google_compute_target_http_proxy" "application_lb" {
  name = "lb-http-proxy"
  url_map = google_compute_url_map.lb.self_link
}


resource "google_compute_url_map" "lb" {
  name = "lb-url-map"

  default_service = google_compute_backend_service.lb.self_link
}