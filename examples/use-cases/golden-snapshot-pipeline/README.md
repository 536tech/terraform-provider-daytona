# Golden snapshot pipeline

Manages the durable platform layer that runtime sandboxes depend on:

- **Registry credentials** so Daytona can pull your private images.
- **Versioned golden snapshots** — each image tag becomes its own snapshot
  (`python-agent-1.5.0`), so publishing a new version never mutates the one
  production is using, and rollback is a one-line change.
- **Shared volumes** for model weights, datasets, and caches that outlive any
  single sandbox.

## The Terraform/SDK split

Sandboxes themselves are ephemeral and best created at runtime with the
Daytona SDK. The SDK call consumes what Terraform manages here:

```python
from daytona import Daytona, CreateSandboxFromSnapshotParams, VolumeMount

daytona = Daytona()
sandbox = daytona.create(CreateSandboxFromSnapshotParams(
    snapshot="python-agent-1.5.0",                      # daytona_snapshot.this
    volumes=[VolumeMount(volume_id=..., mount_path="/weights")],  # daytona_volume.shared
))
```

Terraform owns the slow-moving, team-owned objects (snapshots, registries,
volumes); the SDK owns the fast-moving ones (sandboxes). The
`unmanaged_snapshots` output flags snapshots published outside Terraform so
the inventory stays honest.

## Rolling out a new version

1. Add the new tag to `versions` in `var.snapshots` and apply — the new
   snapshot builds alongside the old one (`snapshot_states` shows build
   progress).
2. Point your SDK calls at the new snapshot name.
3. Remove the old tag from `versions` and apply to delete the old snapshot.

Works with OpenTofu — only resources and data sources, no provider-defined
actions.
