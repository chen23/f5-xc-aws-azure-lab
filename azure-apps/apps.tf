resource "volterra_healthcheck" "example" {
  name      = format("%s-azure-workload-1", var.projectPrefix)
  namespace = var.namespace

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2
}

resource "volterra_origin_pool" "workload1" {
  name                   = format("%s-azure-workload-1", var.projectPrefix)
  namespace              = var.namespace
  endpoint_selection     = "DISTRIBUTED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8080
  no_tls                 = true

  origin_servers {
    private_ip {
      ip = var.workload_ip
      site_locator {
        site {
          namespace = "system"
          name      = format("%s-azure-1", var.projectPrefix)
        }
      }
    }
}
  healthcheck {
    name = format("%s-azure-workload-1", var.projectPrefix)
  }

}


resource "volterra_http_loadbalancer" "workload1" {
  name                            = format("%s-azure-workload-1", var.projectPrefix)
  namespace                       = var.namespace
  no_challenge                    = true
  domains                         = ["workload.azure1.example.internal","workload.global.example.internal"]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true

  advertise_custom {
    advertise_where {
      port = 80
      site {
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = format("%s-azure-1", var.projectPrefix)
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.workload1.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
  }
}