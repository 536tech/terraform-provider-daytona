data "daytona_organization_invitation" "example" {
  organization_id = "organization-id"
  id              = "invitation-id"
}

output "daytona_organization_invitation_status" {
  value = data.daytona_organization_invitation.example.status
}
