# Repository Overview

## Purpose

This repository contains performance comparison benchmarks for dataflow frameworks:
- **Hydroflow/DFIR** - The Hydro project's dataflow runtime and compiler
- **Timely Dataflow** - Low-latency cyclic dataflow
- **Differential Dataflow** - Incremental computation framework

These benchmarks were migrated from the main Hydro repository to maintain clean dependency boundaries and enable independent benchmark evolution.

## Quick Start

### Running Benchmarks

```bash
# Clone the repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benchmarks

# Run specific benchmark
cargo bench -p benchmarks --bench reachability
```

### View Results

After running benchmarks:
- Console output shows statistical summaries
- HTML reports in `target/criterion/` directory
- Open `target/criterion/index.html` in browser for detailed analysis

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   └── workflows/
│       └── benchmark.yml          # CI/CD for benchmarks
│
├── benchmarks/                     # Main benchmark package
│   ├── Cargo.toml                 # Package configuration
│   ├── README.md                  # Quick reference
│   ├── build.rs                   # Build scripts
│   └── benches/                   # Benchmark implementations
│       ├── arithmetic.rs          # Arithmetic operations
│       ├── fan_in.rs              # Fan-in patterns
│       ├── fan_out.rs             # Fan-out patterns
│       ├── fork_join.rs           # Fork-join patterns
│       ├── futures.rs             # Async operations
│       ├── identity.rs            # Identity transform
│       ├── join.rs                # Join operations
│       ├── micro_ops.rs           # Micro-operations
│       ├── reachability.rs        # Graph reachability
│       ├── symmetric_hash_join.rs # Hash joins
│       ├── upcase.rs              # String transforms
│       ├── words_diamond.rs       # Diamond patterns
│       ├── reachability_edges.txt # Graph data (521K)
│       ├── reachability_reachable.txt # Graph results (38K)
│       └── words_alpha.txt        # Word list (3.7M)
│
├── Cargo.toml                      # Workspace configuration
├── rust-toolchain.toml             # Rust version (1.91.1)
├── clippy.toml                     # Linting rules
├── rustfmt.toml                    # Formatting rules
├── .gitignore                      # Git ignore rules
├── LICENSE                         # Apache-2.0 license
│
├── README.md                       # Main documentation
├── BENCHMARK_GUIDE.md              # Comprehensive guide (2500+ lines)
├── MIGRATION.md                    # Migration details
├── MIGRATION_SUMMARY.md            # Quick migration reference
├── CONTRIBUTING.md                 # Contribution guidelines
└── OVERVIEW.md                     # This file
```

## Documentation Guide

### For First-Time Users
**Start here:** [README.md](README.md)
- Overview of the repository
- Quick start guide
- Basic usage examples

### For Running Benchmarks
**Read this:** [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)
- Detailed descriptions of each benchmark
- How to run and interpret results
- Performance analysis tips
- Troubleshooting guide

### For Contributors
**Read this:** [CONTRIBUTING.md](CONTRIBUTING.md)
- How to add new benchmarks
- Code style and guidelines
- Pull request process
- Best practices

### For Understanding Migration
**Read this:** [MIGRATION.md](MIGRATION.md)
- Why benchmarks were moved
- What was migrated
- Changes made
- Impact on source repository

**Quick reference:** [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)
- Quick checklist
- Key changes
- Verification steps

## Benchmark Inventory

### 12 Benchmarks Included

| Benchmark | Frameworks | Description | Data Files |
|-----------|------------|-------------|------------|
| arithmetic | T, D, H | Basic arithmetic operations | - |
| fan_in | T, D, H | Multiple streams merging | - |
| fan_out | T, D, H | Single stream splitting | - |
| fork_join | T, D, H | Parallel processing pattern | - |
| futures | T, D, H | Async/await operations | - |
| identity | T, D, H | Minimal overhead baseline | - |
| join | T, D, H | Relational join operations | - |
| micro_ops | T, D, H | Individual operator tests | - |
| reachability | T, D, H | Graph reachability algorithm | edges.txt, reachable.txt |
| symmetric_hash_join | T, D, H | Hash join implementation | - |
| upcase | T, D, H | String transformations | - |
| words_diamond | T, D, H | Diamond pattern with strings | words_alpha.txt |

**Legend:** T=Timely, D=Differential, H=Hydroflow

### Data Files

1. **reachability_edges.txt** (521K) - Graph edges for reachability test
2. **reachability_reachable.txt** (38K) - Expected reachable nodes
3. **words_alpha.txt** (3.7M) - English word list for text processing

## Technical Details

### Dependencies

**Isolated to this repository:**
- timely-master v0.13.0-dev.1
- differential-dataflow-master v0.13.0-dev.1
- criterion v0.5.0 (benchmarking framework)
- Supporting: futures, rand, tokio, etc.

**Referenced from main Hydro repo (via git):**
- dfir_rs (with debugging features)
- sinktools

### Rust Configuration

- **Toolchain:** 1.91.1
- **Edition:** 2024
- **Resolver:** 2
- **Components:** rustfmt, clippy, rust-src

### Build System

- Standard Cargo workspace
- Custom build scripts for code generation
- Criterion.rs for benchmarking
- HTML report generation

## CI/CD Workflow

### Automated Benchmarking

The repository includes GitHub Actions workflow that:

**Triggers:**
- Weekly schedule (Sundays at midnight UTC)
- Manual workflow dispatch
- Commits with `[ci-bench]` in message
- Pull requests (for comparison)

**Actions:**
- Build benchmarks
- Run full benchmark suite
- Store results as artifacts (90 days)
- Compare PR performance vs. main branch
- Post notifications

**Usage:**
```bash
# Trigger via commit message
git commit -m "perf: optimize join [ci-bench]"

# Or use GitHub Actions UI for manual trigger
```

## Performance Comparison

### What Gets Measured

Each benchmark typically measures:
- **Execution time** - Mean, median, std dev
- **Throughput** - Items processed per second
- **Memory usage** - Allocations and footprint
- **Statistical confidence** - p-values, confidence intervals

### Comparison Methodology

- All implementations are semantically equivalent
- Same input data and expected outputs
- Statistical analysis via Criterion.rs
- Confidence intervals and significance tests
- Historical baseline comparisons

### Expected Performance Characteristics

**General patterns (workload-dependent):**

**Latency (low-latency scenarios):**
1. Hydroflow/DFIR (optimized)
2. Timely Dataflow
3. Differential Dataflow

**Throughput (batch processing):**
1. Timely Dataflow
2. Hydroflow/DFIR
3. Differential Dataflow

**Memory Efficiency:**
1. Hydroflow/DFIR
2. Timely Dataflow
3. Differential Dataflow

*Note: Actual results vary by workload, data size, and hardware.*

## Common Tasks

### Development Workflow

```bash
# Format code
cargo fmt

# Check lints
cargo clippy

# Build benchmarks
cargo build -p benchmarks --release

# Run single benchmark
cargo bench -p benchmarks --bench identity

# Run all benchmarks
cargo bench -p benchmarks
```

### Benchmark Comparison

```bash
# Save current performance as baseline
cargo bench -p benchmarks -- --save-baseline before

# Make changes...

# Compare against baseline
cargo bench -p benchmarks -- --baseline before

# View detailed HTML reports
open target/criterion/index.html
```

### Adding New Benchmark

```bash
# 1. Create benchmark file
touch benchmarks/benches/my_benchmark.rs

# 2. Add to Cargo.toml
cat >> benchmarks/Cargo.toml << 'EOF'

[[bench]]
name = "my_benchmark"
harness = false
EOF

# 3. Implement benchmark (see CONTRIBUTING.md)

# 4. Test
cargo bench -p benchmarks --bench my_benchmark

# 5. Update documentation
```

## Relationship to Main Repository

### Source Repository
**bigweaver-agent-canary-hydro-zeta**
- Main Hydro/Hydroflow codebase
- Core runtime and compiler (dfir_rs)
- Language implementation (hydro_lang)
- Deployment tools (hydro_deploy)
- No longer contains benchmarks or timely/differential deps

### This Repository
**bigweaver-agent-canary-zeta-hydro-deps**
- Benchmark implementations only
- Timely and Differential dependencies isolated here
- References core Hydro components via git
- Independent evolution and CI/CD

### Dependency Flow
```
This Repo (benchmarks)
    ↓ (git dependency)
Source Repo (dfir_rs, sinktools)
    ↓ (implements)
Hydro Framework
```

## Key Benefits

### Clean Architecture
✅ Dependency isolation  
✅ Clear separation of concerns  
✅ Easier maintenance  

### Independent Evolution
✅ Benchmark updates don't affect core  
✅ Can upgrade frameworks independently  
✅ Separate release cycles  

### Better Developer Experience
✅ Faster builds in main repo  
✅ Simpler dependency tree  
✅ Focused CI/CD workflows  

### Comprehensive Documentation
✅ Detailed guides  
✅ Clear usage examples  
✅ Best practices documented  

## Getting Help

### Resources

1. **Documentation** - Start with README.md
2. **Examples** - Look at existing benchmarks
3. **Guides** - Read BENCHMARK_GUIDE.md
4. **Contributing** - See CONTRIBUTING.md
5. **Issues** - Open GitHub issue

### External Links

- [Hydro Project](https://hydro.run/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## Statistics

- **Total benchmarks:** 12
- **Total implementations:** 36 (12 benchmarks × 3 frameworks)
- **Lines of code:** ~3,000+ (benchmarks only)
- **Documentation:** ~5,000+ lines
- **Data files:** 3 (4.2 MB total)
- **Configuration files:** 6

## Status

✅ **Migration:** Complete  
✅ **Documentation:** Complete  
✅ **CI/CD:** Configured  
✅ **Ready for use:** Yes  

## License

Apache-2.0

See [LICENSE](LICENSE) file for full text.

## Quick Links

- 📖 [Main Documentation](README.md)
- 📊 [Benchmark Guide](BENCHMARK_GUIDE.md)
- 🤝 [Contributing](CONTRIBUTING.md)
- 📦 [Migration Details](MIGRATION.md)
- ✅ [Migration Summary](MIGRATION_SUMMARY.md)
- 🔧 [Source Repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

---

**Last Updated:** November 21, 2024  
**Repository Version:** 1.0  
**Status:** Production Ready
