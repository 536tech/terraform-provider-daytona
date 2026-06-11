data "daytona_organization_member" "example" {
  organization_id = "organization-id"
  user_id         = "user-id"
}

output "daytona_organization_member_email" {
  value = data.daytona_organization_member.example.email
}
