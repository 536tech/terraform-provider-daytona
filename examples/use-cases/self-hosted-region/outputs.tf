output "region_ids" {
  description = "Region key to Daytona region ID."
  value       = { for key, region in daytona_region.this : key => region.id }
}

output "region_credentials" {
  description = "Control-plane credentials per region, for the proxy, SSH gateway, and snapshot manager deployments."
  sensitive   = true
  value = {
    for key, region in daytona_region.this : key => {
      proxy_api_key             = region.proxy_api_key
      ssh_gateway_api_key       = region.ssh_gateway_api_key
      snapshot_manager_username = region.snapshot_manager_username
      snapshot_manager_password = region.snapshot_manager_password
    }
  }
}

output "runner_cloud_init" {
  description = "Rendered runner daemon environment file per runner, keyed by region/runner."
  sensitive   = true
  value       = local.runner_cloud_init
}
