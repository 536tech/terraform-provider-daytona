output "key_values" {
  description = "API key values by name. Daytona returns each value once at create time; pipe these into your secret store."
  sensitive   = true
  value       = { for name, key in daytona_api_key.service : name => key.value }
}

output "unmanaged_keys" {
  description = "API key names that exist in the organization but are not managed by this configuration."
  value = [
    for key in data.daytona_api_keys.all.items :
    key.name if !contains(keys(var.service_keys), key.name)
  ]
}
