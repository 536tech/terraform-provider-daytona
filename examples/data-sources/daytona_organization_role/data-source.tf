data "daytona_organization_role" "example" {
  organization_id = "organization-id"
  id              = "role-id"
}

output "daytona_organization_role_name" {
  value = data.daytona_organization_role.example.name
}
