# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on `timely` and `differential-dataflow` packages. These were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository cleaner and avoid dependency bloat.

## Structure

- `benches/` - Microbenchmarks that use timely and differential-dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

## Performance Comparisons

To compare performance between versions:

1. Run benchmarks in this repository:
   ```bash
   cargo bench -p benches
   ```

2. Results are saved in `target/criterion/`

3. You can compare with historical results using criterion's built-in comparison tools

## Dependencies

This repository depends on:
- `dfir_rs` - Core dataflow library (from main repo via git)
- `sinktools` - Utility tools (from main repo via git)
- `timely` - Timely dataflow framework
- `differential-dataflow` - Differential dataflow library

## Documentation

See [benches/README.md](benches/README.md) for more details about the benchmarks.