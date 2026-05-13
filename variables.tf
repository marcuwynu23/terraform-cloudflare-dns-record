
variable "cloudflare_api_token" {
  description = "Cloudflare API token with Zone:DNS:Edit permission"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "name" {
  description = "DNS record name, use @ for root"
  type        = string
}

variable "type" {
  description = "Record type: A, AAAA, CNAME, MX, TXT, etc."
  type        = string
}

variable "value" {
  description = "Record content / value"
  type        = string
}

variable "ttl" {
  description = "TTL in seconds, 1 = auto"
  type        = number
  default     = 1
}

variable "proxied" {
  description = "Whether to proxy through Cloudflare"
  type        = bool
  default     = false
}

variable "priority" {
  description = "Priority for MX records"
  type        = number
  default     = null
}