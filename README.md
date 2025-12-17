# bigweaver-agent-canary-zeta-hydro-deps

Dependencies repository for Hydro project benchmarks with timely and differential-dataflow.

## Overview

This repository contains benchmarks and code that depend on timely and differential-dataflow. These components are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid introducing external dataflow dependencies into the core Hydro project.

## Purpose

The primary purpose of this repository is to enable performance comparisons between:
- Hydro-native implementations (in the main repository)
- Timely/Differential-Dataflow implementations (in this repository)

This separation allows:
1. **Clean dependency management** - The main repository remains free of timely/differential-dataflow dependencies
2. **Faster core builds** - Development on the core project doesn't require building external dataflow libraries
3. **Performance benchmarking** - Comparative benchmarks can still be run when needed
4. **Clear architectural boundaries** - Separates core implementation from comparative analysis tools

## Benchmarks

The `benches/` directory contains benchmarks using timely and differential-dataflow. See [benches/README.md](benches/README.md) for details on available benchmarks and how to run them.

## Running Benchmarks

```bash
cd benches
cargo bench
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)** - Main Hydro project repository with DFIR-native implementations