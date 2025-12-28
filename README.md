# Hydro Dependencies Repository

This repository contains benchmarks and code that depend on external dataflow frameworks (Timely Dataflow and Differential Dataflow) for performance comparison purposes.

## Purpose

This repository was created to:
1. **Separate external dependencies** - Keep timely and differential-dataflow dependencies separate from the core Hydro implementation
2. **Enable performance comparisons** - Provide benchmarks comparing Hydro with established dataflow frameworks
3. **Maintain smaller dependency trees** - Keep the main Hydro repository focused on core functionality
4. **Improve build times** - Reduce compilation overhead in the main repository

## Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/           # Benchmarks comparing Hydro with Timely/Differential
│   ├── benches/       # Benchmark source files
│   ├── Cargo.toml     # Benchmark dependencies including timely/differential
│   └── README.md      # Detailed benchmark documentation
├── Cargo.toml         # Workspace configuration
└── README.md          # This file
```

## Running Benchmarks

See [benches/README.md](benches/README.md) for detailed instructions on running the benchmarks.

Quick start:
```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

## Integration with Main Repository

This repository references the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) for core dependencies like `dfir_rs` and `sinktools`. Both repositories should be checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/         # Main Hydro repository
└── bigweaver-agent-canary-zeta-hydro-deps/    # This repository (deps)
```

## Benchmarks Included

The following types of benchmarks are included:
- **Graph algorithms** - Reachability and other graph operations
- **Join operations** - Various join patterns with different data types
- **Micro-operations** - Fundamental dataflow operations
- **Complex patterns** - Fork-join, fan-in/fan-out patterns

Each benchmark typically includes implementations using:
- Hydro/DFIR syntax
- Timely Dataflow
- Differential Dataflow
- Baseline Rust implementations

## Contributing

When contributing benchmarks:
- **Add here** if the benchmark compares Hydro with Timely or Differential Dataflow
- **Add to main repo** if the benchmark only tests Hydro functionality

## License

Apache-2.0 (same as the main Hydro repository)