# terraform-cloudflare-dns-record

This Terraform project provisions a Cloudflare DNS record using the official Cloudflare Terraform provider. It supports all common record types (A, AAAA, CNAME, MX, TXT, etc.) with configurable TTL, proxying, and priority.

## Features

- Creates and manages Cloudflare DNS records via Infrastructure as Code
- Supports all common record types: A, AAAA, CNAME, MX, TXT, SRV, etc.
- Configurable TTL, Cloudflare proxy toggle, and MX priority
- Sensitive values (API token) are marked sensitive
- Clean, minimal configuration

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.0`
- A [Cloudflare account](https://dash.cloudflare.com/sign-up)
- A Cloudflare API Token with **Zone DNS Edit** permissions
- Your Cloudflare **Zone ID**

### How to get your Cloudflare API Token

1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com/).
2. Go to **My Profile** → **API Tokens**, or open [this direct link](https://dash.cloudflare.com/profile/api-tokens).
3. Click **Create Token**.
4. Under **Custom token**, click **Get started**.
5. Give the token a descriptive name (e.g., `terraform-dns`).
6. Under **Permissions**, add:
   - `Zone` → `DNS` → `Edit`
7. Under **Zone Resources**, select the zone you want this token scoped to (e.g., `Include` → `Specific zone` → `example.com`).
8. (Optional) Set **TTL** and **IP Address Filtering** as needed.
9. Click **Continue to summary** → **Create Token**.
10. Copy the generated token immediately and store it securely — it won't be shown again.

> Use a scoped API token rather than your Global API Key for least-privilege access.

### How to get your Cloudflare Zone ID

1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com/).
2. Select the domain (zone) you want to manage.
3. On the **Overview** page, find **Zone ID** in the right sidebar under the **API** section.
4. Click the copy icon to copy it.

## Usage

### 1. Clone and configure

```bash
git clone https://github.com/marcuwynu23/terraform-cloudflare-dns-record.git
cd terraform-cloudflare-dns-record
cp terraform.tfvars.example terraform.tfvars
```

### 2. Set your values in `terraform.tfvars`

```hcl
cloudflare_api_token = "your-api-token-here"
zone_id  = "your-zone-id"
name     = "www"
type     = "A"
value    = "203.0.113.10"
proxied  = true
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Preview changes

```bash
terraform plan
```

### 5. Apply

```bash
terraform apply
```

### 6. Destroy (when no longer needed)

```bash
terraform destroy
```

## Variables

| Name                   | Description                                  | Type     | Default | Required |
| ---------------------- | -------------------------------------------- | -------- | ------- | :------: |
| `cloudflare_api_token` | Cloudflare API Token with Zone:DNS:Edit perm | `string` | n/a     |   yes    |
| `zone_id`              | Cloudflare Zone ID                           | `string` | n/a     |   yes    |
| `name`                 | DNS record name (use `@` for root)           | `string` | n/a     |   yes    |
| `type`                 | Record type: A, AAAA, CNAME, MX, TXT, etc.   | `string` | n/a     |   yes    |
| `value`                | Record content / value                       | `string` | n/a     |   yes    |
| `ttl`                  | TTL in seconds (`1` = automatic)             | `number` | `1`     |    no    |
| `proxied`              | Whether to proxy traffic through Cloudflare  | `bool`   | `false` |    no    |
| `priority`             | Priority for MX records                      | `number` | `null`  |    no    |

## Outputs

| Name        | Description                        |
| ----------- | ---------------------------------- |
| `record_id` | The ID of the created DNS record   |
| `hostname`  | The FQDN of the created DNS record |

## Examples

### A Record (proxied)

```hcl
name    = "www"
type    = "A"
value   = "203.0.113.10"
proxied = true
```

### CNAME Record

```hcl
name    = "blog"
type    = "CNAME"
value   = "example.netlify.app"
proxied = true
```

### MX Record

```hcl
name     = "@"
type     = "MX"
value    = "mail.example.com"
priority = 10
```

### TXT Record (SPF)

```hcl
name  = "@"
type  = "TXT"
value = "v=spf1 include:_spf.google.com ~all"
```

## Security Notes

- `terraform.tfvars` and `*.tfstate` files are gitignored — never commit secrets
- The API token variable is marked `sensitive` to prevent accidental log exposure
- Use a scoped API token rather than a Global API Key

## References

- [Cloudflare DNS records](https://developers.cloudflare.com/dns/manage-dns-records/)
- [Cloudflare Terraform provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
- [cloudflare_record resource](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)

## License

MIT
