# CI and service-account API keys

Issues least-privilege, expiring Daytona API keys for every non-human
consumer — CI pipelines, agent runtimes, dashboards — instead of sharing one
broad personal key.

- Each key's permissions and expiry are reviewable in the diff.
- A precondition forces an explicit `allow_non_expiring = true` opt-out for
  keys without an expiry, so non-expiring keys are a visible decision.
- `key_values` surfaces each key's value exactly once (Daytona never returns
  it again); feed it straight into your secret store:

  ```sh
  terraform output -json key_values \
    | jq -r '."github-actions-acceptance"' \
    | gh secret set DAYTONA_API_KEY
  ```

- `unmanaged_keys` lists keys created outside Terraform, for periodic cleanup.

Rotation: change `expires_at` (or taint the resource) and apply — keys are
immutable in Daytona, so Terraform plans a replacement and a fresh value
appears in `key_values`.

Works with OpenTofu — only resources and data sources, no provider-defined
actions.
