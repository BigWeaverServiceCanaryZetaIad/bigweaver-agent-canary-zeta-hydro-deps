# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on heavyweight packages like `timely` and `differential-dataflow`. These have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Reduce compilation time for the main repository
- Prevent dependency bloat in the core codebase
- Maintain clean separation of concerns
- Preserve performance comparison functionality

## Contents

- **benches/**: Performance benchmarks for Hydro and related crates

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository