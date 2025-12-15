# Device CI – iOS & Android

This repository runs end-to-end Flutter integration tests on real device simulators/emulators (iOS + Android) using a proxy workflow that boots a backend node, exposes it via Cloudflare Tunnel, and then triggers platform-specific device workflows.

## Architecture

```sql
Push / PR
   │
   ▼
Device CI (matrix of devices)
   │
   ▼
Device CI Proxy (per device)
   │
   ├─ Start encointer-node (Docker)
   ├─ Bootstrap demo community
   ├─ Expose node via Cloudflare Tunnel (WS endpoint)
   └─ Trigger platform workflow (iOS / Android)
          │
          ▼
   iOS Device CI  OR  Android CI
          │
          ├─ Health-check backend via JSON-RPC
          ├─ Start simulator / emulator
          ├─ Run Flutter integration tests
          └─ Upload screenshots & recordings
```

The reason for this architecture is that we need:

1. Run the encointer-node on a Linux environment (GitHub Actions runner) (MacOS runners do not support nested virtualization aka Docker).
2. We need the workflow trigger architecture because GitHub Actions does not support keeping a job alive while another is depending on it.
3. To communicate to the node on another job, we need to expose it via a public endpoint. We use Cloudflare Tunnel for this.