output "record_id" {
  value = cloudflare_record.new_record.id
}

output "hostname" {
  value = cloudflare_record.new_record.hostname
}