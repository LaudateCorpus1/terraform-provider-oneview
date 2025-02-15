provider "oneview" {
  ov_username   = var.username
  ov_password   = var.password
  ov_endpoint   = var.endpoint
  ov_sslverify  = var.ssl_enabled
  ov_apiversion = 3600
  ov_ifmatch    = "*"
}

//Get attachment by id
data "oneview_storage_attachment" "storage_attach" {
  name = "<name>" //Give attachment id here
}

output "oneview_storage_attachment" {
  value = data.oneview_storage_attachment.storage_attach.uri
}

