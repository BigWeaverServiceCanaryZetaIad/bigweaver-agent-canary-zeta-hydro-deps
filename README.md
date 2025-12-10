# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks and dependencies that are separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository isolates benchmarks that depend on `timely-dataflow` and `differential-dataflow` to keep the main Hydro repository's dependency footprint lean while retaining the ability to run performance comparisons.

## Contents

- **benches**: Performance comparison benchmarks comparing Hydro with timely-dataflow and differential-dataflow implementations

## Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
```

See [benches/README.md](benches/README.md) for more details about available benchmarks.