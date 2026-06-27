output "record_id" {
  value = cloudflare_dns_record.new_record.id
}

output "hostname" {
  value = cloudflare_dns_record.new_record.name
}