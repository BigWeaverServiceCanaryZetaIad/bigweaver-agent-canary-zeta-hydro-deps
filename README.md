# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing DFIR (Dataflow Intermediate Representation) with external dataflow frameworks like timely-dataflow and differential-dataflow.

## Purpose

This repository is separate from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Keep timely-dataflow and differential-dataflow dependencies isolated
- Avoid polluting the main repository's build with external dependencies
- Maintain the ability to run performance comparisons between DFIR and other frameworks
- Improve build performance of the main repository

## Structure

- `benches/` - Benchmark suite comparing DFIR with timely-dataflow and differential-dataflow implementations

## Running Benchmarks

To run the benchmarks:

```bash
cd benches
cargo bench
```

Individual benchmarks can be run with:

```bash
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- `arithmetic` - Arithmetic operations benchmark
- `fan_in` - Fan-in pattern benchmark
- `fan_out` - Fan-out pattern benchmark
- `fork_join` - Fork-join pattern benchmark
- `identity` - Identity operation benchmark
- `join` - Join operation benchmark
- `micro_ops` - Micro-operations benchmark
- `reachability` - Graph reachability benchmark
- `symmetric_hash_join` - Symmetric hash join benchmark
- `upcase` - String uppercase benchmark
- `words_diamond` - Word processing diamond pattern benchmark

## Dependencies

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for DFIR runtime components. The path dependency is configured as:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

Ensure both repositories are cloned at the same level in your workspace.

## License

Apache-2.0
