output "snapshot_names" {
  description = "Snapshot names ready to pass to the SDK's CreateSandboxFromSnapshotParams."
  value       = sort(keys(daytona_snapshot.this))
}

output "snapshot_states" {
  description = "Build state per managed snapshot."
  value       = { for name, snapshot in daytona_snapshot.this : name => snapshot.state }
}

output "volume_ids" {
  description = "Shared volume name to Daytona volume ID, for SDK volume mounts."
  value       = { for name, volume in daytona_volume.shared : name => volume.id }
}

output "unmanaged_snapshots" {
  description = "Snapshots that exist in the organization but are not managed by this configuration."
  value = [
    for snapshot in data.daytona_snapshots.all.items :
    snapshot.name if !contains(keys(daytona_snapshot.this), snapshot.name)
  ]
}
