output "role_ids" {
  description = "Custom role name to Daytona role ID."
  value       = { for name, role in daytona_organization_role.this : name => role.id }
}

output "pending_invitations" {
  description = "Invitation status per invited email."
  value       = { for email, invitation in daytona_organization_invitation.this : email => invitation.status }
}

output "unmanaged_members" {
  description = "User IDs that exist in the organization but are not managed by this configuration."
  value = [
    for member in data.daytona_organization_members.current.items :
    member.id if !contains(keys(var.members), member.id)
  ]
}
