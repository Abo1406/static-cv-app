terraform {
  backend "s3" {}
}

provider "digitalocean" {}

# Deploy HTTPd container
module "app" {
  source           = "../../modules/docker-app"
  app_name         = "myapp-dev"
  region           = "nyc1"
  registry_type    = "DOCKER_HUB"
  image_repository = "yourdockerhubuser/myhttpd-app"
  image_tag        = var.image_tag
  domain           = var.domain
  envs             = { ENV = "dev" }
}

# DNS records
module "dns" {
  source     = "../../modules/dns"
  domain     = var.domain
  app_cname  = replace(module.app.app_url, "https://", "")
}

output "app_url"   { value = module.app.app_url }
output "domain"    { value = module.dns.domain }
