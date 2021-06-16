provider "oneview" {
  ov_username   = var.username
  ov_password   = var.password
  ov_endpoint   = var.endpoint
  ov_sslverify  = var.ssl_enabled
  ov_apiversion = 2800
  ov_ifmatch    = "*"
}

# Updates Subnet Name
resource "oneview_id_pools_ipv4_subnets" "ipv4_subnets" {
  name = "RenamedSF"
  network_id="192.169.1.0"
  subnet_mask="255.255.255.0"
  gateway="192.169.1.1"
}

# Below resources are prerequisite for update_resource_allocator.tf
# which allocates IPs from subnet to the resource

# Gets subnet details using id
data "oneview_id_pools_ipv4_subnets" "ipv4_subnets_data" {
  subnet_id = "e3dc8b2a-cee0-4c16-82a8-c48092993853"
}

# Creates Range of Ip Addresses for the subnet 
# To allocate ips from subnet to associated resource
resource "oneview_ipv4_range" "ipv4range" {
  name = "IpRange"
  subnet_uri = data.oneview_id_pools_ipv4_subnets.ipv4_subnets_data.uri
  start_stop_fragments {
    start_address = "192.169.1.10"
    end_address = "192.169.1.20"
  }
}

# Associate Ethernet Resource with subnet
resource "oneview_ethernet_network" "ethernetnetwork" {
  name    = "SubnetEthernet"
  type    = "ethernet-networkV4"
  vlan_id = 157
  subnet_uri = data.oneview_id_pools_ipv4_subnets.ipv4_subnets_data.uri
}
