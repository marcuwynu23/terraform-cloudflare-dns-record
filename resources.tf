resource "cloudflare_record" "new_record" {
  zone_id  = var.zone_id
  name     = var.name
  type     = var.type
  content  = var.value
  ttl      = var.proxied ? 1 : var.ttl
  proxied  = var.proxied
  priority = var.priority
}