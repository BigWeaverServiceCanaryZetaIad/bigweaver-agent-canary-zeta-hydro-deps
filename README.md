# bigweaver-agent-canary-zeta-hydro-deps

Performance benchmarking repository for comparing DFIR/Hydro with timely-dataflow and differential-dataflow implementations.

## Overview

This repository contains performance benchmarks that were separated from the main [`bigweaver-agent-canary-hydro-zeta`](https://github.com/hydro-project/hydro) repository to maintain clean dependency separation. By isolating benchmarks that require timely and differential-dataflow dependencies, we prevent these dependencies from affecting the main codebase build times and dependency tree.

## Purpose

### Why a Separate Repository?

The main `bigweaver-agent-canary-hydro-zeta` repository focuses on core DFIR/Hydro functionality. Adding timely and differential-dataflow as dependencies would:
- ❌ Increase build times significantly
- ❌ Introduce unnecessary dependencies for most users
- ❌ Create potential version conflicts
- ❌ Complicate the dependency tree

This separate repository allows:
- ✅ **Clean Separation**: Core functionality separate from performance comparison tools
- ✅ **Faster Builds**: Main repository builds without timely/differential dependencies
- ✅ **Focused Development**: Each repository has a clear, singular purpose
- ✅ **Independent Versioning**: Benchmarks can evolve independently
- ✅ **Optional Usage**: Teams can choose whether to run cross-framework comparisons

### Use Cases

This repository is intended for:
1. **Performance Engineers**: Comparing DFIR/Hydro performance against industry-standard frameworks
2. **Researchers**: Academic analysis of dataflow system performance characteristics
3. **Contributors**: Ensuring performance regressions are caught before merging changes
4. **Optimization Work**: Identifying performance bottlenecks through cross-framework comparison

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark package
│   ├── benches/                # Individual benchmark files
│   │   ├── arithmetic.rs       # Arithmetic operations benchmark
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── identity.rs        # Identity/passthrough benchmark
│   │   ├── join.rs            # Join operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── upcase.rs          # String transformation benchmark
│   │   ├── reachability_edges.txt         # Test data (521KB)
│   │   └── reachability_reachable.txt     # Test data (38KB)
│   ├── build.rs               # Build script for code generation
│   ├── Cargo.toml             # Benchmark dependencies
│   └── README.md              # Detailed benchmark documentation
├── Cargo.toml                  # Workspace configuration
├── LICENSE                     # Apache 2.0 License
├── README.md                   # This file
├── rust-toolchain.toml         # Rust version specification
├── rustfmt.toml               # Code formatting configuration
└── clippy.toml                # Linting configuration
```

## Getting Started

### Prerequisites

- **Rust**: Version specified in `rust-toolchain.toml` (automatically installed via rustup)
- **Git**: For cloning the repository
- **Cargo**: Comes with Rust installation

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the benchmarks:
   ```bash
   cargo build --release
   ```

3. Run the benchmarks:
   ```bash
   cargo bench
   ```

## Running Benchmarks

### Quick Start

Run all benchmarks:
```bash
cargo bench
```

### Run Specific Benchmarks

```bash
# Arithmetic operations
cargo bench --bench arithmetic

# Fan-in pattern
cargo bench --bench fan_in

# Fan-out pattern
cargo bench --bench fan_out

# Fork-join pattern
cargo bench --bench fork_join

# Identity/passthrough
cargo bench --bench identity

# Join operations
cargo bench --bench join

# Graph reachability
cargo bench --bench reachability

# String operations
cargo bench --bench upcase
```

### Filter Benchmark Tests

Run only specific tests within a benchmark:
```bash
# Run only DFIR tests in arithmetic benchmark
cargo bench --bench arithmetic -- dfir

# Run only timely tests
cargo bench --bench arithmetic -- timely
```

### Viewing Results

After running benchmarks, detailed HTML reports are generated in:
```
target/criterion/report/index.html
```

Open this file in a web browser to view:
- Performance comparisons with graphs
- Statistical analysis (mean, median, std dev)
- Historical performance trends
- Outlier detection

## Performance Comparison Workflow

To compare DFIR/Hydro against timely/differential-dataflow:

### Step 1: Run Benchmarks in This Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

This gives you metrics for:
- Timely dataflow implementations
- Differential dataflow implementations
- DFIR implementations (with timely/differential context)

### Step 2: Run Main Repository Benchmarks

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

This gives you metrics for:
- Pure DFIR implementations
- Native Hydro implementations
- Benchmarks that don't require timely/differential

### Step 3: Analyze Results

1. **Compare HTML reports**: View both `target/criterion/report/index.html` files
2. **Look for patterns**: Which framework performs better for which workload?
3. **Investigate differences**: Understand why certain patterns favor certain frameworks
4. **Document findings**: Record insights for future optimization work

### Step 4: Track Over Time

Run benchmarks regularly to:
- Detect performance regressions
- Validate optimization efforts
- Monitor the impact of dependency updates
- Ensure consistent performance characteristics

## Benchmark Descriptions

For detailed information about each benchmark, see [`benches/README.md`](benches/README.md).

### Quick Overview

| Benchmark | Description | Key Metric |
|-----------|-------------|------------|
| **arithmetic** | Basic arithmetic operations through dataflow pipelines | Throughput (ops/sec) |
| **fan_in** | Multiple inputs merged into single output | Merge latency |
| **fan_out** | Single input split to multiple outputs | Split throughput |
| **fork_join** | Parallel processing with merge | End-to-end latency |
| **identity** | Passthrough with minimal transformation | Framework overhead |
| **join** | Relational join operations | Join throughput |
| **reachability** | Graph reachability computation | Computation time |
| **upcase** | String transformation operations | String processing speed |

## Dependencies

### Core Dependencies

- **[timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)**: Low-latency data-parallel dataflow system
  - Version: `0.13.0-dev.1` (package: `timely-master`)
  
- **[differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)**: Incremental computation framework
  - Version: `0.13.0-dev.1` (package: `differential-dataflow-master`)

- **[dfir_rs](https://github.com/hydro-project/hydro)**: DFIR runtime from the main Hydro project
  - Source: Git repository (synchronized with main project)

### Supporting Dependencies

- **[criterion](https://github.com/bheisler/criterion.rs)**: Statistical benchmarking framework
- **tokio**: Async runtime for async benchmarks
- **rand/rand_distr**: Random number generation for test data
- **futures**: Futures-based async utilities

See [`benches/Cargo.toml`](benches/Cargo.toml) for complete dependency list.

## Configuration

### Rust Toolchain

The repository uses a specific Rust version defined in `rust-toolchain.toml`. This ensures consistent behavior across different environments. Rustup will automatically install and use the correct version.

### Code Formatting

Code is formatted using `rustfmt` with settings in `rustfmt.toml`:
- Import grouping
- Doc comment formatting
- Field initialization shorthand
- And more...

Format code with:
```bash
cargo fmt
```

### Linting

Code is linted with `clippy` using settings in `clippy.toml`:
- Upper-case acronym handling
- Breaking API change detection
- And more...

Lint code with:
```bash
cargo clippy
```

## Development

### Adding New Benchmarks

1. **Create benchmark file** in `benches/benches/`:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_test", |b| {
           b.iter(|| {
               // Benchmark code here
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

2. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. **Update documentation**:
   - Add description to `benches/README.md`
   - Update this README's overview table
   - Document any test data requirements

4. **Test the benchmark**:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Modifying Existing Benchmarks

1. Edit the benchmark file in `benches/benches/`
2. Test your changes: `cargo bench --bench <name>`
3. Review HTML report for expected behavior
4. Update documentation if behavior changes

### Build Scripts

The `benches/build.rs` script generates code for certain benchmarks. If you need to:
- Modify generation logic: Edit `build.rs`
- Change generated code size: Adjust constants (e.g., `NUM_OPS`)
- Add new generated benchmarks: Extend the build script

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Performance Benchmarks

on:
  pull_request:
    branches: [ main ]
  push:
    branches: [ main ]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install Rust
        uses: actions-rs/toolchain@v1
        with:
          profile: minimal
          toolchain: stable
          override: true
      
      - name: Run Benchmarks
        run: cargo bench --no-fail-fast
      
      - name: Archive Benchmark Results
        uses: actions/upload-artifact@v3
        with:
          name: benchmark-results
          path: target/criterion/
```

### Integration with Main Repository

When coordinating changes across both repositories:

1. **Create companion PRs**: Link PRs in both repositories
2. **Document dependencies**: Note which changes depend on each other
3. **Coordinate reviews**: Ensure both PRs are reviewed together
4. **Merge together**: Merge companion PRs in coordination

See the main repository's [CONTRIBUTING.md](https://github.com/hydro-project/hydro/blob/main/CONTRIBUTING.md) for more details.

## Relationship to Main Repository

### Dependency Flow

```
Main Repository (bigweaver-agent-canary-hydro-zeta)
├── Core DFIR/Hydro implementation
├── Basic benchmarks (no timely/differential)
└── Development without extra dependencies

This Repository (bigweaver-agent-canary-zeta-hydro-deps)
├── References main repository via git
├── Adds timely/differential dependencies
└── Provides cross-framework benchmarks
```

### When to Use Which Repository

**Use the main repository** when:
- Developing core DFIR/Hydro features
- Running basic performance tests
- Building applications with Hydro
- Contributing to the core project

**Use this repository** when:
- Comparing performance against timely/differential
- Analyzing cross-framework characteristics
- Conducting performance research
- Validating optimization claims

## Troubleshooting

### Build Issues

**Problem**: Compilation errors with timely/differential
```
Solution: Ensure dependencies are up to date:
cargo update
cargo clean
cargo build
```

**Problem**: Git dependencies fail to fetch
```
Solution: Check network connection and git authentication:
git config --global credential.helper store
```

### Benchmark Issues

**Problem**: Benchmarks take too long
```
Solution: Reduce sample size or constants:
cargo bench -- --sample-size 10
# Or edit NUM_INTS/NUM_OPS in benchmark files
```

**Problem**: Inconsistent results
```
Solution: Ensure stable system conditions:
- Close other applications
- Disable CPU frequency scaling
- Use release builds only
```

### Missing Files

**Problem**: `reachability_edges.txt` not found
```
Solution: Ensure data files are present:
ls benches/benches/*.txt
# Files should be checked into git
```

## Contributing

Contributions are welcome! To contribute:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/my-benchmark`
3. **Commit** changes following conventional commits format
4. **Push** to your fork: `git push origin feature/my-benchmark`
5. **Open** a pull request with:
   - Clear description of changes
   - Benchmark results showing impact
   - Updated documentation

### Code Review Guidelines

- All benchmarks must use Criterion.rs
- Follow existing code style (enforced by rustfmt)
- Pass clippy lints
- Include documentation for new benchmarks
- Provide rationale for benchmark additions

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Related Projects

- **[Hydro Project](https://github.com/hydro-project/hydro)**: Main DFIR/Hydro repository
- **[Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)**: Low-latency dataflow system
- **[Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)**: Incremental computation
- **[Criterion.rs](https://github.com/bheisler/criterion.rs)**: Benchmarking framework

## Support

For questions or issues:
- **Issues**: Open an issue in this repository
- **Main Project**: For DFIR/Hydro questions, see the [main repository](https://github.com/hydro-project/hydro)
- **Timely/Differential**: For framework-specific questions, see their respective repositories

## Acknowledgments

This repository structure follows team preferences for:
- Separation of dependencies into dedicated repositories
- Proactive technical debt management
- Modular architecture with clear boundaries
- Independent benchmark development

The benchmark implementations are derived from the original Hydro project benchmarks, adapted for cross-framework comparison.