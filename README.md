# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmark dependencies for the BigWeaver Hydro project.

## Benches

The `benches/` directory contains performance benchmarks that compare Hydro against other dataflow frameworks like Timely Dataflow and Differential Dataflow.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

See the [benches/README.md](benches/README.md) for more details.
