# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) that depend on timely and differential-dataflow.

## Purpose

The benchmarks in this repository have been separated from the main Hydro repository to:

1. **Avoid unnecessary dependencies**: The main repository doesn't need to include timely and differential-dataflow as dependencies
2. **Maintain performance comparisons**: These benchmarks allow comparing Hydro's performance against timely and differential-dataflow
3. **Preserve benchmarking capability**: The separation doesn't sacrifice the ability to run comparative benchmarks

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that use timely and differential-dataflow. See [benches/README.md](benches/README.md) for details on:
- Available benchmarks
- How to run them
- How to compare results with the main repository's benchmarks

## Running Benchmarks

```bash
cd benches
cargo bench
```

For detailed instructions and benchmark descriptions, see [benches/README.md](benches/README.md).

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository with dfir_rs benchmarks