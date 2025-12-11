# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely and differential-dataflow, separated from the main bigweaver-agent-canary-hydro-zeta repository.

## Repository Structure

```
.
├── benches/                    # Benchmark suite
│   ├── benches/               # Individual benchmark files
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Benchmark documentation
├── run_benchmarks.sh         # Helper script for running benchmarks
└── README.md                 # This file
```

## Adding New Benchmarks

To add a new benchmark that depends on timely or differential-dataflow:

1. Create your benchmark file in `benches/benches/your_benchmark.rs`
2. Add the benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```
3. Document the benchmark in `benches/README.md`
4. Run the benchmark to verify it works: `cargo bench --bench your_benchmark`

## Running Benchmarks

See [benches/README.md](benches/README.md) for detailed instructions on running benchmarks.

Quick start:
```bash
cd benches
cargo bench
```

## Updating Dependencies

The benchmarks depend on:
- `timely-master` - Timely dataflow framework
- `differential-dataflow-master` - Differential dataflow framework
- `dfir_rs` and `sinktools` from the main repository (via git)

When updating git dependencies, ensure compatibility with the main repository.

## Performance Comparison Workflow

To compare performance between this repository and the main repository:

1. **Run benchmarks in this repository:**
   ```bash
   cd benches
   cargo bench
   ```

2. **Run benchmarks in the main repository:**
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results:**
   - Results are stored in `target/criterion/` in each repository
   - Open `target/criterion/report/index.html` for visual comparisons
   - Use criterion's built-in comparison tools

## Code Style

Follow the same code style as the main bigweaver-agent-canary-hydro-zeta repository:
- Run `cargo fmt` before committing
- Run `cargo clippy` to check for issues
- Write clear, documented benchmarks

## Questions?

For questions about Hydro development, see the main repository's [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).
