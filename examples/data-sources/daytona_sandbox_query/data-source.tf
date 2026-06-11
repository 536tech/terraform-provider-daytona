data "daytona_sandbox_query" "running_agents" {
  name_prefix = "agent"
  states      = ["started"]
  sort        = "createdAt"
  order       = "desc"
  limit       = 50
}
