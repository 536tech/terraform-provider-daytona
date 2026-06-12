variable "regions" {
  description = "Daytona regions to register, each with its control-plane endpoints and runner hosts."
  type = map(object({
    name                 = string
    proxy_url            = optional(string)
    ssh_gateway_url      = optional(string)
    snapshot_manager_url = optional(string)
    runners = map(object({
      tags     = list(string)
      draining = optional(bool)
    }))
  }))

  default = {
    us-east = {
      name                 = "us-east"
      proxy_url            = "https://proxy.us-east.example.com:8080"
      ssh_gateway_url      = "ssh.us-east.example.com:22"
      snapshot_manager_url = "https://snapshots.us-east.example.com:5000"
      runners = {
        runner-1 = { tags = ["terraform", "general"] }
        runner-2 = { tags = ["terraform", "gpu"] }
      }
    }
    eu-west = {
      name = "eu-west"
      runners = {
        runner-1 = { tags = ["terraform", "general"] }
      }
    }
  }
}

variable "credential_rotation_id" {
  description = "Change this value to rotate every region credential (proxy API key, SSH gateway API key, snapshot manager credentials)."
  type        = string
  default     = "initial"
}
