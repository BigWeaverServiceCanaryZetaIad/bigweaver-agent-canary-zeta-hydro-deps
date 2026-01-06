# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main Hydro repository to reduce complexity and improve maintainability.

## Contents

### Benchmarks (`/benches`)

Comparative performance benchmarks for Hydro against Timely Dataflow and Differential Dataflow implementations:

- **arithmetic**: Pipeline operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **identity**: Identity operations benchmark
- **join**: Join operations benchmark
- **reachability**: Graph reachability benchmark (includes Differential Dataflow comparisons)
- **upcase**: String uppercase transformation benchmark

See `/benches/README.md` for detailed usage instructions.

## Running Benchmarks

```bash
cargo bench
```

For specific benchmarks:
```bash
cargo bench --bench reachability
```