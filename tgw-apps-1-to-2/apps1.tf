resource "volterra_http_loadbalancer" "workload1-to-2" {
  name                            = format("%s-tgw-workload-1-to-2", var.projectPrefix)
  namespace                       = var.namespace
  no_challenge                    = true
  domains                         = ["workload.tgw2.example.internal"]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true

  advertise_custom {
    advertise_where {
      port = 80
      site {
        ### TODO should be variable
        ip = "100.64.15.254"      
        network = "SITE_NETWORK_INSIDE"
        site {
          name      = format("%s-tgw-1", var.projectPrefix)
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.workload2.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
  }
}