provider "oneview" {
  ov_username   = var.username
  ov_password   = var.password
  ov_endpoint   = var.endpoint
  ov_sslverify  = var.ssl_enabled
  ov_apiversion = 3600
  ov_ifmatch    = "*"
}

data "oneview_ethernet_network" "eth1" {
  name = "Auto-Ethernet-1"
}

data "oneview_ethernet_network" "eth2" {
  name = "Auto-Ethernet-2"
}

data "oneview_scope" "scope_obj" {
  name = "Auto-Scope"
}

# Updates the Resource
resource "oneview_network_set" "NetworkSet" {
  name               = "TestNetworkSet_update"
  native_network_uri = ""
  type               = "network-setV5"
  network_uris       = [data.oneview_ethernet_network.eth1.uri, data.oneview_ethernet_network.eth2.uri]
  initial_scope_uris = [data.oneview_scope.scope_obj.uri]
}

