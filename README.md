# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require external dependencies (Timely and Differential Dataflow). These have been separated from the main repository to keep the core Hydro codebase clean and focused.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks between Hydro and other dataflow frameworks:

- **Timely benchmarks**: Compare Hydro with Timely dataflow
  - `fan_in.rs`: Fan-in operations benchmark
  - `upcase.rs`: String transformation operations benchmark

- **Differential Dataflow benchmarks**: Compare Hydro with Differential Dataflow
  - `reachability.rs`: Graph reachability algorithms benchmark

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench upcase
cargo bench -p benches --bench reachability
```

## Purpose

This repository maintains the ability to run performance comparisons with Timely and Differential Dataflow while keeping these dependencies separate from the main Hydro repository. This separation helps to:

1. Keep the main repository focused on core Hydro functionality
2. Avoid unnecessary dependencies in the main project
3. Maintain performance testing capabilities
4. Support continuous performance monitoring

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main Hydro repository