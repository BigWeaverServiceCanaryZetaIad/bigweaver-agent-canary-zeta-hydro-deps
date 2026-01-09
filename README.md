# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance comparison tools for the bigweaver-agent-canary-hydro-zeta project that depend on `timely` and `differential-dataflow` packages.

## Purpose

These benchmarks have been moved to a separate repository to:
- Avoid adding `timely` and `differential-dataflow` as direct dependencies in the main repository
- Maintain the ability to run performance comparisons independently
- Keep the main repository's dependency footprint minimal
- Enable focused performance testing without affecting the main codebase

## Structure

```
benches/
├── timely_benchmarks/          # Benchmarks using timely dataflow
│   ├── fanout_bench.rs         # Fan-out operation performance
│   ├── join_bench.rs           # Join operation performance
│   ├── reachability_bench.rs   # Graph reachability performance
│   └── README.md
└── differential_benchmarks/    # Benchmarks using differential dataflow
    ├── arrange_bench.rs        # Arrange operation performance
    ├── reduce_bench.rs         # Reduce operation performance
    ├── iterate_bench.rs        # Iterative computation performance
    └── README.md
```

## Running Benchmarks

### Prerequisites

Ensure you have Rust installed with `cargo` available in your path.

### Run All Benchmarks

```bash
# Run timely benchmarks
cd benches/timely_benchmarks
cargo run --bin fanout_bench --release
cargo run --bin join_bench --release
cargo run --bin reachability_bench --release

# Run differential benchmarks
cd ../differential_benchmarks
cargo run --bin arrange_bench --release
cargo run --bin reduce_bench --release
cargo run --bin iterate_bench --release
```

### Run with Multiple Workers

Many benchmarks support running with multiple workers for distributed testing:

```bash
cargo run --bin join_bench --release -- -w 4
```

### Performance Comparison

To compare performance between versions:

1. Run benchmarks and capture output
2. Compare metrics across different configurations
3. Use the `--release` flag for accurate performance measurements

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in the appropriate benchmark directory
2. Add the binary target to the corresponding `Cargo.toml`
3. Update the README with benchmark description and usage

### Dependencies

This repository maintains its own workspace dependencies:
- `timely`: Timely dataflow framework
- `differential-dataflow`: Differential dataflow framework

These dependencies are intentionally kept separate from the main bigweaver-agent-canary-hydro-zeta repository.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta): Main project repository
