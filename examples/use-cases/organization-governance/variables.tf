variable "organization_id" {
  description = "Daytona organization ID to govern."
  type        = string
}

variable "roles" {
  description = "Custom organization roles, keyed by role name."
  type = map(object({
    description = string
    permissions = set(string)
  }))

  default = {
    sandbox-operator = {
      description = "Create and manage sandboxes and their volumes."
      permissions = ["write:sandboxes", "delete:sandboxes", "read:volumes", "write:volumes"]
    }
    snapshot-publisher = {
      description = "Publish and manage golden snapshots and registries."
      permissions = ["write:snapshots", "delete:snapshots", "write:registries"]
    }
    read-only = {
      description = "Read-only visibility for auditors and dashboards."
      permissions = ["read:sandboxes", "read:snapshots", "read:volumes", "read:registries"]
    }
  }
}

variable "members" {
  description = "Existing organization members, keyed by Daytona user ID."
  type = map(object({
    role         = string
    custom_roles = optional(list(string), [])
  }))
  default = {}
}

variable "invitations" {
  description = "Pending invitations, keyed by email address."
  type = map(object({
    role         = string
    custom_roles = optional(list(string), [])
    expires_at   = optional(string)
  }))
  default = {}
}

variable "region_quotas" {
  description = "Per-region, per-sandbox-class compute quotas."
  type = map(object({
    region_id     = string
    sandbox_class = string
    total_cpu     = number
    total_memory  = number
    total_disk    = number
    total_gpu     = optional(number, 0)
  }))
  default = {}
}

variable "otel_endpoint" {
  description = "Optional OpenTelemetry collector endpoint for sandbox telemetry."
  type        = string
  default     = null
}

variable "otel_headers" {
  description = "Optional headers sent to the OpenTelemetry collector."
  type        = map(string)
  default     = null
  sensitive   = true
}
