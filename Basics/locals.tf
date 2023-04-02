locals {
  time = timestamp()
  application = "web_server"
  server_name = "${var.account}-${local.application}"
}