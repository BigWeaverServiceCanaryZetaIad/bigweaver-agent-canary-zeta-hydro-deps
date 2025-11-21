# Project Summary: Timely and Differential Dataflow Benchmarks

## Overview

This repository provides comprehensive performance benchmarks for **timely-dataflow** and **differential-dataflow**, two powerful Rust frameworks for data-parallel and incremental computation.

## What's Included

### Benchmark Packages

#### 1. Timely Dataflow Benchmarks (`timely-benchmarks/`)

5 benchmark suites covering core timely operations:

- **barrier.rs** - Synchronization overhead (1K-100K elements)
- **exchange.rs** - Data exchange patterns and partitioning
- **dataflow_construction.rs** - Graph construction costs (5-20 operator depth/width)
- **progress_tracking.rs** - Progress tracking mechanism performance
- **unary_operators.rs** - Map, filter, flat_map operators (1K-100K elements)

**Key Features:**
- Tests single and multi-threaded execution
- Measures raw dataflow performance
- Provides baseline metrics

#### 2. Differential Dataflow Benchmarks (`differential-benchmarks/`)

5 benchmark suites for incremental computation:

- **arrange.rs** - Data arrangement by key (1K-100K elements, 10-1K keys)
- **join.rs** - Join operations (100-10K elements, varying selectivity)
- **count.rs** - Aggregation/counting (1K-100K elements)
- **consolidate.rs** - Data consolidation (with update patterns)
- **distinct.rs** - Deduplication (with duplicate factors)

**Key Features:**
- Tests incremental updates
- Measures arrangement overhead
- Evaluates join performance

### Documentation

| File | Purpose |
|------|---------|
| `README.md` | Project overview and quick start |
| `INSTALLATION.md` | Detailed setup instructions |
| `BENCHMARKING.md` | Complete benchmarking guide |
| `COMPARISON.md` | Performance comparison methodology |
| `CONTRIBUTING.md` | Contribution guidelines |

### Tooling

- **run-benchmarks.sh** - Flexible benchmark runner with options
- **setup-validation.sh** - Installation verification
- **Makefile** - Convenient commands for common tasks
- **.github/workflows/benchmarks.yml** - CI/CD configuration

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace configuration
├── README.md                           # Main documentation
├── INSTALLATION.md                     # Setup guide
├── BENCHMARKING.md                     # Benchmarking guide
├── COMPARISON.md                       # Performance comparison
├── CONTRIBUTING.md                     # Contribution guide
├── Makefile                            # Build automation
├── run-benchmarks.sh                   # Benchmark runner
├── setup-validation.sh                 # Validation script
├── .gitignore                          # Git ignore rules
├── .github/workflows/benchmarks.yml    # CI configuration
│
├── timely-benchmarks/                  # Timely dataflow benchmarks
│   ├── Cargo.toml                      # Package config
│   ├── README.md                       # Package docs
│   ├── src/lib.rs                      # Utility library
│   └── benches/                        # Benchmark files
│       ├── barrier.rs
│       ├── exchange.rs
│       ├── dataflow_construction.rs
│       ├── progress_tracking.rs
│       └── unary_operators.rs
│
└── differential-benchmarks/            # Differential dataflow benchmarks
    ├── Cargo.toml                      # Package config
    ├── README.md                       # Package docs
    ├── src/lib.rs                      # Utility library
    └── benches/                        # Benchmark files
        ├── arrange.rs
        ├── join.rs
        ├── count.rs
        ├── consolidate.rs
        └── distinct.rs
```

## Key Features

### 1. Comprehensive Coverage

- **10 distinct benchmark suites** covering major operations
- **Multiple parameter variations** (size, keys, workers)
- **Both frameworks** represented equally

### 2. Performance Analysis

- **Criterion.rs integration** for statistical rigor
- **HTML reports** with visualizations
- **Baseline comparisons** for tracking changes
- **Multi-worker configurations** for scalability testing

### 3. Easy to Use

- **Simple commands**: `make bench`, `make test`
- **Flexible runner**: `./run-benchmarks.sh --workers 4`
- **Quick mode**: For development iteration
- **Comprehensive docs**: Step-by-step guides

### 4. CI/CD Ready

- **GitHub Actions workflow** included
- **Automated testing** on push/PR
- **Multi-worker matrix** testing
- **Artifact upload** for results

### 5. Developer Friendly

- **Utility libraries** for data generation
- **Unit tests** for utilities
- **Clear examples** in documentation
- **Contribution guidelines** included

## Quick Start Commands

```bash
# Initial setup
./setup-validation.sh

# Run all benchmarks
make bench

# Quick development test
make bench-quick

# Specific package
make bench-timely
make bench-differential

# With 4 workers
./run-benchmarks.sh --workers 4

# Save baseline
./run-benchmarks.sh --save-baseline main

# Compare against baseline
./run-benchmarks.sh --baseline main

# View results
make view-results
```

## Use Cases

### 1. Framework Selection

Compare timely vs differential for your use case:
```bash
cargo bench --package timely-benchmarks --bench unary_operators
cargo bench --package differential-benchmarks --bench distinct
```

Consult `COMPARISON.md` for interpretation.

### 2. Performance Regression Testing

Track performance across versions:
```bash
# On main branch
cargo bench --all -- --save-baseline main

# After changes
cargo bench --all -- --baseline main
```

### 3. Optimization Validation

Verify improvements:
```bash
# Before optimization
./run-benchmarks.sh --save-baseline before

# After optimization
./run-benchmarks.sh --baseline before
```

### 4. Scalability Analysis

Test multi-worker performance:
```bash
make bench-all-workers  # Tests 1, 2, 4 workers
```

### 5. Research and Education

Understand framework behavior:
- Run benchmarks with varying parameters
- Analyze HTML reports
- Study benchmark implementations

## Technical Details

### Dependencies

- **timely**: 0.12 - Low-latency dataflow
- **differential-dataflow**: 0.12 - Incremental computation
- **criterion**: 0.5 - Statistical benchmarking
- **rand**: 0.8 - Data generation

### Configuration

- **Edition**: Rust 2021
- **Profile**: Optimized release builds
- **LTO**: Fat link-time optimization
- **Strip**: Symbols stripped for size

### Benchmark Design

- **Sample sizes**: 100+ iterations for statistical significance
- **Warm-up**: Adequate JIT warm-up time
- **Isolation**: Each benchmark measures one operation
- **Parameters**: Multiple sizes tested (1K, 10K, 100K)
- **Realistic**: Real-world usage patterns

## Performance Characteristics

### Timely Dataflow

**Strengths:**
- Low overhead for simple operations
- Direct control over execution
- Minimal memory footprint
- Fast one-shot computations

**Best For:**
- Batch processing
- Simple streaming pipelines
- Low-latency requirements
- Memory-constrained environments

### Differential Dataflow

**Strengths:**
- Extremely fast incremental updates
- Automatic state management
- Complex query support
- Multi-way joins

**Best For:**
- Incremental computation
- Frequently updated data
- Complex join queries
- Maintaining query results

See `COMPARISON.md` for detailed analysis and benchmarks.

## Extensibility

Easy to add new benchmarks:

1. Create new `.rs` file in `benches/`
2. Add to `Cargo.toml` as `[[bench]]`
3. Follow existing patterns
4. Update package README
5. Submit PR

See `CONTRIBUTING.md` for detailed guide.

## CI/CD Integration

GitHub Actions workflow includes:
- **Build validation** on all targets
- **Test execution** for all packages
- **Benchmark runs** in quick mode
- **Multi-worker matrix** (1, 2, 4 workers)
- **Artifact preservation** (30 days)
- **Baseline comparisons** on PRs

## Maintenance

### Regular Updates

- Dependencies: Update quarterly
- Benchmarks: Add as new patterns emerge
- Documentation: Keep current with changes

### Quality Checks

All PRs must pass:
- `cargo fmt --all -- --check`
- `cargo clippy --all-targets -- -D warnings`
- `cargo test --all`
- `cargo bench --all -- --quick`

## Resources

### Learning Materials

- [Timely Dataflow Paper](https://dl.acm.org/doi/10.1145/2517349.2522738)
- [Differential Dataflow Overview](https://timelydataflow.github.io/differential-dataflow/)
- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

### Community

- [Timely GitHub](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential GitHub](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Users Forum](https://users.rust-lang.org/)

## Metrics

### Repository Stats

- **Languages**: Rust, Shell, Markdown
- **Packages**: 2 (timely-benchmarks, differential-benchmarks)
- **Benchmarks**: 10 suites
- **Documentation**: 6 comprehensive guides
- **LOC**: ~2000+ lines of benchmark code
- **Tests**: Unit tests for utilities

### Benchmark Coverage

| Category | Timely | Differential |
|----------|--------|--------------|
| Basic Ops | ✓ | ✓ |
| Aggregation | ✓ | ✓ |
| Joins | - | ✓ |
| Updates | - | ✓ |
| Scalability | ✓ | ✓ |

## Future Enhancements

Potential additions:
- Window operations benchmarks
- Iteration/recursion benchmarks
- Multi-node distributed benchmarks
- Comparison with other frameworks
- Memory profiling integration
- Flamegraph generation

## License

Apache-2.0

## Contact

Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
Owner: BigWeaverServiceCanaryZetaIad

## Acknowledgments

Built on the excellent work of:
- [TimelyDataflow project](https://github.com/TimelyDataflow)
- [Criterion.rs](https://github.com/bheisler/criterion.rs)
- Rust community

---

**Status**: ✅ Ready for use
**Version**: 0.1.0
**Last Updated**: 2024
**Maintained**: Yes
