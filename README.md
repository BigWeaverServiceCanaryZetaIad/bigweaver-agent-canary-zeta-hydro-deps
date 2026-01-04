# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely-dataflow and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches-hydro-deps
```

Run specific benchmarks:
```
cargo bench -p benches-hydro-deps --bench reachability
cargo bench -p benches-hydro-deps --bench join
cargo bench -p benches-hydro-deps --bench arithmetic
cargo bench -p benches-hydro-deps --bench fan_in
cargo bench -p benches-hydro-deps --bench fan_out
cargo bench -p benches-hydro-deps --bench fork_join
cargo bench -p benches-hydro-deps --bench identity
cargo bench -p benches-hydro-deps --bench upcase
```

## Benchmarks

This repository includes benchmarks for:
- **reachability**: Graph reachability benchmarks using timely and differential-dataflow
- **join**: Join operation benchmarks using timely-dataflow
- **arithmetic**: Arithmetic operation benchmarks using timely-dataflow
- **fan_in**: Fan-in pattern benchmarks using timely-dataflow
- **fan_out**: Fan-out pattern benchmarks using timely-dataflow
- **fork_join**: Fork-join pattern benchmarks using timely-dataflow
- **identity**: Identity operation benchmarks using timely-dataflow
- **upcase**: String upper-casing benchmarks using timely-dataflow