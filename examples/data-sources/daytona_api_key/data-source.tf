data "daytona_api_key" "example" {
  name = "api-key-name"
}

output "daytona_api_key_permissions" {
  value = data.daytona_api_key.example.permissions
}
