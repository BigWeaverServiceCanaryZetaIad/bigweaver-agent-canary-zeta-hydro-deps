# bigweaver-agent-canary-zeta-hydro-deps

A dedicated repository for Hydroflow performance benchmarks with external framework dependencies (Timely Dataflow and Differential Dataflow).

## Overview

This repository maintains performance comparison benchmarks between Hydroflow/dfir_rs and other dataflow frameworks. By separating these benchmarks from the main Hydroflow repository, we achieve:

- **Cleaner main repository** - Core functionality without external framework dependencies
- **Independent performance testing** - Run benchmarks without building the entire project
- **Modular architecture** - Clear separation of concerns between core and comparison code
- **Easier maintenance** - Isolated dependency management for external frameworks

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                           # Benchmark suite
│   ├── Cargo.toml                    # Benchmark package configuration
│   ├── README.md                      # Detailed benchmark documentation
│   ├── build.rs                       # Build-time code generation
│   └── benches/                       # Benchmark implementations
│       ├── arithmetic.rs              # Arithmetic operations
│       ├── fan_in.rs                  # Fan-in pattern
│       ├── fan_out.rs                 # Fan-out pattern
│       ├── fork_join.rs               # Fork-join pattern
│       ├── identity.rs                # Identity transformation
│       ├── join.rs                    # Join operations
│       ├── reachability.rs            # Graph reachability (Differential)
│       ├── upcase.rs                  # String transformation
│       └── *.txt                      # Test data files
└── README.md                          # This file
```

## Quick Start

### Prerequisites

- Rust 1.70 or later
- Cargo package manager
- Git (for dependency resolution)

### Running Benchmarks

**Run all benchmarks:**
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benchmarks
```

**Run specific benchmark:**
```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
cargo bench -p timely-differential-benchmarks --bench join
cargo bench -p timely-differential-benchmarks --bench reachability
```

**Run specific framework implementation:**
```bash
# Test only Timely implementations
cargo bench --bench arithmetic -- timely

# Test only Hydroflow implementations
cargo bench --bench arithmetic -- dfir_rs
```

### Viewing Results

Benchmark results are generated in `target/criterion/`:

```bash
# Open HTML report in browser
open target/criterion/report/index.html

# View specific benchmark
open target/criterion/arithmetic/report/index.html
```

## Benchmark Suite

### Available Benchmarks

| Benchmark | Description | Frameworks |
|-----------|-------------|------------|
| **arithmetic** | Repeated arithmetic operations | Timely, Hydroflow, Raw Rust |
| **identity** | Identity transformation throughput | Timely, Hydroflow |
| **fan_in** | Multiple streams merging | Timely, Hydroflow |
| **fan_out** | Stream splitting/branching | Timely, Hydroflow |
| **fork_join** | Split and rejoin patterns | Timely, Hydroflow |
| **join** | Hash join operations | Timely, Hydroflow |
| **reachability** | Iterative graph computation | Differential, Hydroflow |
| **upcase** | String transformation | Timely, Hydroflow |

### Performance Comparisons

These benchmarks enable direct performance comparisons between:

- **Timely Dataflow** - Low-latency cyclic dataflow
- **Differential Dataflow** - Incremental computation on Timely
- **Hydroflow (dfir_rs)** - Hydro project's dataflow runtime

Each benchmark implements the same algorithm across different frameworks to provide fair comparisons.

## Dependencies

### External Frameworks

- **timely** (0.13.0-dev.1) - Timely Dataflow from GitHub
- **differential-dataflow** (0.13.0-dev.1) - Differential Dataflow from GitHub

### Hydroflow Components

- **dfir_rs** - Hydroflow runtime (from main repository)
- **sinktools** - Hydroflow utilities

### Support Libraries

- **criterion** - Statistical benchmarking
- **tokio** - Async runtime
- **futures** - Async abstractions
- **rand** - Random number generation

## Integration with Main Repository

This repository complements the main Hydroflow repository:

- **Main repo**: `bigweaver-agent-canary-hydro-zeta`
  - Core Hydroflow functionality
  - Native benchmarks (futures, micro_ops, etc.)
  - No external framework dependencies

- **This repo**: `bigweaver-agent-canary-zeta-hydro-deps`
  - Comparative benchmarks
  - External framework dependencies
  - Performance analysis tools

### Using Local Development Versions

To test against local Hydroflow development:

```toml
# Edit benches/Cargo.toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Performance Testing Workflow

### 1. Run Quick Tests

For rapid iteration:
```bash
# Run single benchmark with fewer iterations
cargo bench --bench arithmetic -- --sample-size 10
```

### 2. Run Full Benchmark Suite

For comprehensive analysis:
```bash
# Run all benchmarks with default settings
cargo bench -p timely-differential-benchmarks
```

### 3. Compare Results

Criterion automatically compares against previous runs:
```bash
# View comparison reports
open target/criterion/report/index.html
```

### 4. Export Results

```bash
# Results are saved in target/criterion/<benchmark-name>/
# Copy for archival or sharing
cp -r target/criterion/arithmetic/report /path/to/results/
```

## Understanding Benchmark Results

Each benchmark provides:

- **Throughput** - Operations per second
- **Latency** - Time per operation
- **Statistical analysis** - Mean, median, standard deviation
- **Comparisons** - Performance changes between runs
- **Plots** - Visual representation of results

### Example Output

```
arithmetic/timely        time:   [45.123 ms 45.456 ms 45.789 ms]
                         change: [-2.3% -1.5% -0.7%] (p = 0.01 < 0.05)
                         Performance has improved.

arithmetic/dfir_rs       time:   [42.234 ms 42.567 ms 42.890 ms]
                         change: [+0.5% +1.2% +1.9%] (p = 0.05)
                         No significant change detected.
```

## Development

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/`:
```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn benchmark_new_pattern(c: &mut Criterion) {
    c.bench_function("new_pattern/timely", |b| {
        // Implementation
    });
}

criterion_group!(benches, benchmark_new_pattern);
criterion_main!(benches);
```

2. Add to `benches/Cargo.toml`:
```toml
[[bench]]
name = "new_pattern"
harness = false
```

3. Document in `benches/README.md`

4. Test the benchmark:
```bash
cargo bench --bench new_pattern
```

### Modifying Existing Benchmarks

1. Edit the `.rs` file in `benches/benches/`
2. Run the specific benchmark to verify changes
3. Check for performance regressions
4. Update documentation if behavior changes

## Architectural Decisions

### Why Separate Repository?

1. **Dependency Management**
   - Timely and Differential Dataflow are large dependencies
   - Not needed for core Hydroflow functionality
   - Allows independent version management

2. **Build Performance**
   - Main repository builds faster without external frameworks
   - Benchmarks can be run independently
   - CI/CD pipelines can be optimized separately

3. **Maintenance**
   - Clear boundaries between core and comparison code
   - Easier to update external framework versions
   - Reduced impact on main repository stability

4. **Team Workflow**
   - Performance testing as a separate concern
   - Independent release cycles possible
   - Cleaner commit history in main repo

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta** - Main Hydroflow repository
  - Core dataflow runtime
  - Language implementations
  - Native benchmarks

## Contributing

Contributions are welcome! Please:

1. Follow existing code structure and style
2. Add benchmarks for new patterns or operations
3. Document benchmark purpose and usage
4. Ensure benchmarks run successfully
5. Update this README with changes

## Troubleshooting

### Common Issues

**Build fails with dependency errors:**
```bash
# Clear cargo cache and retry
cargo clean
cargo bench --bench arithmetic
```

**Benchmarks take too long:**
```bash
# Reduce sample size for testing
cargo bench --bench arithmetic -- --sample-size 10 --quick
```

**Git dependency resolution fails:**
```bash
# Check network connectivity
# Verify git can access GitHub
git ls-remote https://github.com/TimelyDataflow/timely-dataflow.git
```

### Getting Help

- Check `benches/README.md` for detailed benchmark documentation
- Review Criterion documentation for benchmarking questions
- Consult main Hydroflow repository for dfir_rs questions
- Create an issue for bugs or feature requests

## License

Apache-2.0

## References

- [Hydroflow Project](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)

## Changelog

### 2025-11-24 - Initial Repository Setup
- Migrated timely and differential-dataflow benchmarks from main repository
- Added 8 benchmark implementations (arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase)
- Configured Cargo.toml with proper dependencies
- Created comprehensive documentation
- Established independent benchmark execution environment