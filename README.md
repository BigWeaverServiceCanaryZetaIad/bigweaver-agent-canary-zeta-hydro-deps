# Hydro Timely and Differential-Dataflow Benchmarks

This repository contains benchmarks for timely and differential-dataflow operations, separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation.

## Overview

This repository hosts performance benchmarks that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main repository to:
- Eliminate unnecessary dependencies in the main codebase
- Maintain clean separation of concerns
- Enable independent performance testing and comparison

## Available Benchmarks

The following benchmarks are available:

- **arithmetic** - Arithmetic operations benchmarks
- **fan_in** - Fan-in pattern performance testing
- **fan_out** - Fan-out pattern performance testing  
- **fork_join** - Fork-join operation benchmarks
- **futures** - Async futures performance testing
- **identity** - Identity operation baseline benchmarks
- **join** - Join operation performance testing
- **micro_ops** - Micro-operation benchmarks
- **reachability** - Graph reachability benchmarks
- **symmetric_hash_join** - Symmetric hash join performance
- **upcase** - String uppercase transformation benchmarks
- **words_diamond** - Diamond pattern with word processing

## Running Benchmarks

### Prerequisites

This repository depends on the main hydro repository being available at:
```
../bigweaver-agent-canary-hydro-zeta
```

Ensure both repositories are cloned in the same parent directory.

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench --bench reachability

# Run benchmarks matching a pattern
cargo bench --bench fan_
```

### View Benchmark Results

Benchmark results are saved in:
```
target/criterion/
```

Open `target/criterion/report/index.html` in a browser to view detailed HTML reports.

## Performance Comparison with Main Repository

To compare performance between this repository and the main hydro repository, use the comparison script:

```bash
./compare_performance.sh
```

This script will:
1. Run benchmarks in both repositories
2. Compare the results
3. Generate a comparison report

For detailed comparison between specific commits or branches:
```bash
./compare_performance.sh --baseline <commit-hash-or-branch>
```

## Data Files

- `benches/words_alpha.txt` - English word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)
- `benches/reachability_edges.txt` - Graph edges for reachability benchmarks
- `benches/reachability_reachable.txt` - Expected reachable nodes for verification

## Dependencies

This repository depends on:
- **timely-master** (v0.13.0-dev.1) - Timely dataflow system
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - From main hydro repository (via path dependency)
- **sinktools** - From main hydro repository (via path dependency)
- **criterion** - For benchmark harness and reporting

## Development

### Building

```bash
cargo build --release
```

### Testing

```bash
cargo test
```

### Adding New Benchmarks

1. Create a new benchmark file in `benches/`
2. Add a `[[bench]]` section in `Cargo.toml`
3. Follow the existing benchmark patterns using criterion
4. Update this README with the new benchmark description

## Repository Structure

```
.
├── Cargo.toml              # Package configuration
├── README.md               # This file
├── build.rs                # Build script for generated benchmarks
├── benches/                # Benchmark implementations
│   ├── arithmetic.rs
│   ├── fan_in.rs
│   ├── fan_out.rs
│   ├── fork_join.rs
│   ├── futures.rs
│   ├── identity.rs
│   ├── join.rs
│   ├── micro_ops.rs
│   ├── reachability.rs
│   ├── symmetric_hash_join.rs
│   ├── upcase.rs
│   ├── words_diamond.rs
│   ├── *.txt               # Data files for benchmarks
│   └── .gitignore
└── compare_performance.sh  # Performance comparison tool

```

## Migration History

These benchmarks were migrated from the bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency separation. See `CHANGES.md` for detailed migration history.

## License

Apache-2.0

## Repository

https://github.com/hydro-project/hydro
