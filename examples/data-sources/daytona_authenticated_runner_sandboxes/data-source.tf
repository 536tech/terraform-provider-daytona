data "daytona_authenticated_runner_sandboxes" "example" {
  states                     = "started,stopped"
  skip_reconciling_sandboxes = true
}
