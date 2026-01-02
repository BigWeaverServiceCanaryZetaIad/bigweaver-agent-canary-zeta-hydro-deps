# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro/DFIR performance against other dataflow frameworks (Timely Dataflow and Differential Dataflow).

## Contents

- **benches/**: Microbenchmarks for DFIR and other dataflow frameworks
  - Timely Dataflow comparison benchmarks
  - Differential Dataflow comparison benchmarks
  - Various operation benchmarks (join, reachability, map operations, etc.)

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench upcase
```

See `benches/README.md` for more details on individual benchmarks.