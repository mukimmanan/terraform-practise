module "server" {
  source = "./modules/server"
  ami             = ""
  security_groups = []
  subnet_id       = ""
}