resource "digitalocean_app" "web" {
  spec {
    name = var.app_name
    region = var.region

    services {
      name  = "web"

      image {
        registry_type = var.registry_type
        repository    = var.image_repository
        tag           = var.image_tag
       }
       httpd_port  = 80
       run_command = [ "/usr/sbin/httpd", "-D", "FOREGROUND"]
       envs        = var.envs
   }
  domains = [ var.domain, "www.${var.domain}"]
 }
}
