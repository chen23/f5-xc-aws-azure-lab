############################ Volterra Azure VNet Sites ############################

resource "volterra_azure_vnet_site" "azure-site" {
  name        = format("%s-azure-2", var.projectPrefix)
  namespace      = "system"
  alternate_region   = var.azureRegion2
  resource_group = "${var.resourceGroup}-site"
  machine_type   = "Standard_D3_v2"
  ssh_key        = var.ssh_public_key

  assisted                = false
  logs_streaming_disabled = true
  no_worker_nodes         = true

  azure_cred {
    name      = var.volterraCloudCredAzure
    namespace = "system"
  }

  ingress_egress_gw_ar {
    azure_certified_hw       = "azure-byol-multi-nic-voltmesh"
    no_forward_proxy         = true
    no_global_network        = true
    no_network_policy        = true
    no_outside_static_routes = true


    node {
      fault_domain = 3
      update_domain = 5
      node_number = 3
#      disk_size = 80

      inside_subnet {
        subnet {
          subnet_name         = "internal_subnet"
          vnet_resource_group = true
        }
      }
      outside_subnet {
        subnet {
          subnet_name         = "external_subnet"
          vnet_resource_group = true
        }
      }
    }


    inside_static_routes {
      static_route_list {
        custom_static_route {
          subnets {
            ipv4 {
              prefix = "10.2.16.0"
              plen   = "20"
            }
          }
          nexthop {
            type = "NEXT_HOP_USE_CONFIGURED"
            nexthop_address {
              ipv4 {
                addr = "100.64.65.1"
              }
            }
          }
          attrs = [
            "ROUTE_ATTR_INSTALL_FORWARDING",
            "ROUTE_ATTR_INSTALL_HOST"
          ]
        }
      }
    }
  }

  vnet {
    existing_vnet {
      resource_group = var.resourceGroup
      vnet_name      = var.hubVnetName
    }
  }

}

resource "volterra_cloud_site_labels" "labels" {
  name = volterra_azure_vnet_site.azure-site.name
    site_type = "azure_vnet_site"
    labels = {
      site-group = var.projectPrefix
      key1 = "value1"
      key2 = "value2"
    }
  ignore_on_delete = true
}

resource "volterra_tf_params_action" "azure-site" {
  site_name        = volterra_azure_vnet_site.azure-site.name
  site_kind        = "azure_vnet_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = false

  depends_on = [volterra_azure_vnet_site.azure-site]
}

