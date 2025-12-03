# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been separated from the main repository to improve build times and maintain a cleaner codebase.

## 📋 Overview

The repository includes:

- **Timely and Differential-Dataflow Benchmarks**: Performance comparison benchmarks for evaluating Hydro against timely and differential-dataflow implementations
- **Benchmark Infrastructure**: Tools and utilities for running comprehensive performance tests

## 🎯 Purpose

This repository serves several key purposes:

1. **Dependency Isolation**: Keep heavy dependencies (timely, differential-dataflow) separate from the main Hydro codebase
2. **Performance Testing**: Enable comprehensive performance comparisons and regression testing
3. **Build Optimization**: Reduce build times in the main repository by isolating benchmark dependencies
4. **Technical Debt Management**: Maintain clean architecture boundaries between core functionality and testing infrastructure

## 🔧 Structure

```
.
├── benches/                    # Benchmark suite
│   ├── benches/               # Individual benchmark files
│   │   ├── micro_ops.rs      # Micro-operation benchmarks
│   │   ├── reachability.rs   # Graph algorithm benchmarks
│   │   └── dataflow_patterns.rs  # Common pattern benchmarks
│   ├── src/                   # Shared utilities
│   │   └── lib.rs            # Test data generators and helpers
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Detailed benchmark documentation
├── Cargo.toml                 # Workspace configuration
├── run_benchmarks.sh          # Convenience script for running benchmarks
└── README.md                  # This file
```

## 🚀 Quick Start

### Running Benchmarks

Run all benchmarks:
```bash
bash run_benchmarks.sh --all
```

Run specific benchmark suites:
```bash
bash run_benchmarks.sh --micro          # Micro-operations only
bash run_benchmarks.sh --reachability   # Graph algorithms only
bash run_benchmarks.sh --dataflow       # Dataflow patterns only
```

### Performance Comparison Workflow

1. **Create a baseline**:
   ```bash
   bash run_benchmarks.sh --all --baseline main
   ```

2. **Make changes** in the Hydro repository

3. **Compare against baseline**:
   ```bash
   bash run_benchmarks.sh --all --compare main
   ```

### Using Cargo Directly

```bash
cd benches
cargo bench                          # Run all benchmarks
cargo bench --bench micro_ops        # Run specific suite
cargo bench -- timely_map            # Run specific benchmark
```

## 📊 Benchmark Suites

### Micro-Operations
Tests fundamental dataflow operations:
- Map transformations
- Filter operations
- Combined map-filter pipelines

### Reachability
Tests graph algorithms with various topologies:
- Small sparse graphs
- Medium chain graphs
- Dense graphs

### Dataflow Patterns
Tests common distributed computing patterns:
- Count aggregations
- Join operations
- Reduce operations
- Map-reduce pipelines

## 📚 Dependencies

The benchmark suite includes:
- `timely`: 0.12 - Timely dataflow system
- `differential-dataflow`: 0.12 - Differential dataflow computations
- `criterion`: 0.5 - Statistical benchmarking framework

## 🔗 Integration with Main Repository

These benchmarks can be used to validate performance of changes in the main Hydro repository:

1. Make changes in `bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks in this repository
3. Compare results to ensure no performance regressions

## 📖 Documentation

For detailed information about:
- Adding new benchmarks
- Interpreting results
- CI/CD integration
- Troubleshooting

See [benches/README.md](benches/README.md)

## 🤝 Contributing

When contributing benchmarks:

1. Follow the existing code structure and naming conventions
2. Document what each benchmark measures
3. Use appropriate input sizes to test different scales
4. Include both small and large test cases
5. Update documentation accordingly

## 🔧 Development

### Building

```bash
cargo build --workspace
```

### Testing

```bash
cd benches
cargo test
```

### Adding Dependencies

Update `benches/Cargo.toml` to add new dependencies needed for benchmarks.

## 📝 Notes

- This repository is specifically for benchmark and dependency isolation
- Core Hydro functionality remains in `bigweaver-agent-canary-hydro-zeta`
- Benchmarks use statistical analysis to detect performance changes
- Results may vary based on system load and hardware configuration

## 🔗 Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) - Main Hydro repository

## 📄 License

Apache-2.0

---

For questions or issues related to benchmarks, please refer to the main Hydro repository's issue tracker.