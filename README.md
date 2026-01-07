# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the BigWeaver Agent Canary Zeta project, specifically those that require Timely Dataflow and Differential Dataflow dependencies.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro/DFIR against Timely Dataflow and Differential Dataflow. These benchmarks are essential for performance comparisons and regression testing.

The benchmarks include:
- **fan_in**: Fan-in operation performance (many sources to one sink)
- **fork_join**: Alternating fork and join operations
- **reachability**: Graph reachability algorithms with iterative/recursive patterns

For detailed information on running and understanding the benchmarks, see [benches/README.md](benches/README.md).

## Quick Start

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## Purpose

This repository exists to:
1. Isolate dependencies (timely and differential-dataflow) from the main BigWeaver repository
2. Retain the ability to run performance comparisons against other dataflow frameworks
3. Provide a dedicated location for benchmark code and data files