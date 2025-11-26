# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that would otherwise add unnecessary dependencies to the main Hydro repository.

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks comparing Hydro/dfir_rs against Timely Dataflow and Differential Dataflow. These benchmarks are separated to avoid adding `timely` and `differential-dataflow` as dependencies to the main repository.

See [benches/README.md](benches/README.md) for more information on running the benchmarks.

## Repository Structure

```
.
├── benches/              # Timely and Differential Dataflow benchmarks
│   ├── benches/         # Individual benchmark files
│   ├── Cargo.toml
│   ├── build.rs         # Build script for generated benchmarks
│   └── README.md
└── README.md
```

## Usage

This repository is designed to work alongside the main `bigweaver-agent-canary-hydro-zeta` repository. The benchmarks reference code from the main repository via relative path dependencies.

To run benchmarks:
```bash
cargo bench -p benches
```