variable "service_keys" {
  description = "Scoped API keys per consuming system, keyed by key name."
  type = map(object({
    permissions        = set(string)
    expires_at         = optional(string)
    allow_non_expiring = optional(bool, false)
  }))

  default = {
    github-actions-acceptance = {
      permissions = ["write:sandboxes", "delete:sandboxes", "write:volumes", "delete:volumes"]
      expires_at  = "2026-12-31T23:59:59Z"
    }
    agent-runtime = {
      permissions = ["write:sandboxes", "delete:sandboxes", "read:snapshots", "read:volumes"]
      expires_at  = "2026-09-30T23:59:59Z"
    }
    dashboard-read-only = {
      permissions        = ["read:sandboxes", "read:snapshots", "read:volumes", "read:registries"]
      allow_non_expiring = true
    }
  }
}
