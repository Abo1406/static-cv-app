resource "digitalocean_domain" "primary" {
  name = var.domain
}

resource "digitalocean_domain" "apex" {
  domain = digitalocean_domain.primary.name
  type   = "CNAME"
  name   = "@"
  value  = var.app_cname
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.primary.name
  type   = "CNAME"
  name   = "www"
  value  = var.app_cname
}

resource "digitalocean_certificate" "cert" {
  name    = "le-${var.domain}-cert"
  type    = "lets_encrypt"
  domains = [var.domain, "www.${var.domain}"]
}
