variable "registries" {
  description = "Private Docker registries Daytona pulls golden images from, keyed by registry name."
  type = map(object({
    url      = string
    username = string
    project  = optional(string)
  }))
  default = {}
}

# Separate from var.registries because Terraform cannot for_each over a
# sensitive value.
variable "registry_passwords" {
  description = "Registry password or token per registry, keyed like var.registries."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "snapshots" {
  description = "Golden snapshot families. Each version becomes its own snapshot named <key>-<version>."
  type = map(object({
    image      = string
    versions   = list(string)
    cpu        = optional(number)
    memory     = optional(number)
    disk       = optional(number)
    entrypoint = optional(list(string))
  }))

  default = {
    python-agent = {
      image    = "ghcr.io/example/python-agent"
      versions = ["1.4.0", "1.5.0"]
      cpu      = 2
      memory   = 4
      disk     = 10
    }
    node-ci = {
      image      = "ghcr.io/example/node-ci"
      versions   = ["20.11.0"]
      cpu        = 4
      memory     = 8
      disk       = 20
      entrypoint = ["sleep", "infinity"]
    }
  }
}

variable "shared_volumes" {
  description = "Names of shared volumes that sandboxes mount at runtime."
  type        = set(string)
  default     = ["model-weights", "dataset-cache"]
}
