# Quick Reference Card

## Essential Commands

### Building
```bash
make build              # Build all packages
cargo build            # Standard build
cargo build --benches  # Build benchmarks
```

### Testing
```bash
make test              # Run all tests
cargo test --all       # Standard test
```

### Benchmarking
```bash
make bench             # Run all benchmarks
make bench-quick       # Fast iteration (fewer samples)
cargo bench            # Standard benchmark run
cargo bench --bench arithmetic  # Run specific benchmark
```

### Code Quality
```bash
make fmt               # Format code
make clippy            # Run lints
make pre-commit        # Run all checks before commit
```

### Performance Analysis
```bash
./compare_benchmarks.sh         # Compare with Hydroflow
./check_performance.sh main     # Check for regressions
make report                     # Open HTML report
```

## File Structure

```
📁 bigweaver-agent-canary-zeta-hydro-deps/
├── 📄 README.md              # Start here
├── 📄 SETUP.md               # Installation guide
├── 📄 BENCHMARKS.md          # Benchmark details
├── 📄 CONTRIBUTING.md        # How to contribute
├── 📄 QUICK_REFERENCE.md     # This file
├── ⚙️  Makefile               # Build commands
├── 🔧 compare_benchmarks.sh   # Comparison script
└── 📁 benches/               # Benchmarks
    └── benches/
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        └── upcase.rs
```

## 8 Benchmarks

| Benchmark | Type | Description |
|-----------|------|-------------|
| arithmetic | Flow | Sequential operations |
| identity | Flow | Passthrough overhead |
| upcase | Flow | String transformation |
| fan_in | Graph | N→1 convergence |
| fan_out | Graph | 1→N distribution |
| fork_join | Graph | Fork-join pattern |
| join | Relational | Hash join |
| reachability | Incremental | Graph algorithm |

## Quick Start (3 Steps)

```bash
# 1. Build
cargo build

# 2. Run benchmark
cargo bench --bench arithmetic

# 3. View results
open target/criterion/report/index.html
```

## Common Workflows

### Daily Development
```bash
make check              # Quick compilation check
make bench-quick        # Fast benchmark
make fmt && make clippy # Code quality
```

### Before Commit
```bash
make pre-commit         # All checks
./check_performance.sh  # Regression check
```

### Performance Comparison
```bash
# Option 1: Script
./compare_benchmarks.sh

# Option 2: Manual
cd bigweaver-agent-canary-zeta-hydro-deps && cargo bench
cd ../bigweaver-agent-canary-hydro-zeta && cargo bench -p benches
# Compare HTML reports
```

## Environment Variables

```bash
# Faster benchmarks (for dev)
CRITERION_SAMPLE_SIZE=10 cargo bench

# More accurate (for release)
CRITERION_SAMPLE_SIZE=200 CRITERION_MEASUREMENT_TIME=10 cargo bench

# Regression threshold
PERF_THRESHOLD=5.0 ./check_performance.sh
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Slow build | `cargo build -j 2` |
| Inconsistent results | Close apps, disable CPU scaling |
| Can't find baseline | `cargo bench -- --save-baseline main` |
| Wide confidence interval | Increase samples, reduce noise |

## Output Locations

```
target/criterion/
├── report/
│   └── index.html          # Main HTML report
├── arithmetic/
│   ├── timely/            # Timely results
│   └── raw/               # Baseline results
└── ...
```

## Documentation Map

- **New users** → README.md → SETUP.md
- **Running benchmarks** → BENCHMARKS.md
- **Contributing** → CONTRIBUTING.md
- **Best practices** → BENCHMARKING_BEST_PRACTICES.md
- **Quick help** → QUICK_REFERENCE.md (this file)

## Help Commands

```bash
make help                # Show Makefile commands
cargo bench --help       # Criterion help
./compare_benchmarks.sh  # Interactive script
```

## Benchmark Name Patterns

```
<benchmark>/<implementation>

Examples:
- arithmetic/timely
- arithmetic/raw
- reachability/differential
- join/timely
```

## Comparison Mapping

| This Repo | Main Repo |
|-----------|-----------|
| arithmetic/timely | arithmetic/dfir_rs/* |
| join/timely | join/dfir_rs/* |
| reachability/timely | reachability/dfir_rs/* |
| reachability/differential | reachability/dfir_rs/* |

## Links

- 🏠 [Main Repo](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- 📚 [Criterion Docs](https://bheisler.github.io/criterion.rs/book/)
- 🔧 [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- 🔄 [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

---

**Keep this handy for quick reference!**
