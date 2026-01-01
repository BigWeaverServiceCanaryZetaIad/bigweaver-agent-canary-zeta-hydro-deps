# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that depend on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks for Hydro against other dataflow systems including:
- Timely Dataflow
- Differential Dataflow

The benchmarks include:
- `identity.rs` - Identity/passthrough operations
- `fan_out.rs` - Fan-out patterns
- `reachability.rs` - Graph reachability algorithms
- Additional micro-benchmarks for various dataflow operations

#### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

See `benches/README.md` for more details.

## Purpose

This repository allows benchmarks to be updated and maintained independently without affecting the main codebase versioning or release schedule. By separating these dependencies, the main Hydro repository avoids requiring `timely-master` and `differential-dataflow-master` packages.
