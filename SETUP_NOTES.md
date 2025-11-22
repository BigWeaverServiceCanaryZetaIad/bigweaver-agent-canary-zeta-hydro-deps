# Setup Notes

## Repository Structure Created

This repository has been set up with Timely Dataflow and Differential Dataflow benchmarks to enable performance comparisons with the main bigweaver-agent-canary-hydro-zeta repository.

## What Has Been Added

### 1. Workspace Configuration

- **Cargo.toml**: Root workspace configuration with two benchmark packages
  - `benches/timely` - Timely Dataflow benchmarks
  - `benches/differential` - Differential Dataflow benchmarks

### 2. Benchmark Implementations

#### Timely Dataflow Benchmarks (`benches/timely/`)
- `arithmetic.rs` - Basic arithmetic operations on streams
- `identity.rs` - Minimal overhead/passthrough operations
- `fan_in.rs` - Merging multiple streams
- `fan_out.rs` - Splitting stream to multiple consumers
- `micro_ops.rs` - Filter, map, and chained operations
- `reachability.rs` - Graph traversal patterns

#### Differential Dataflow Benchmarks (`benches/differential/`)
- `arithmetic.rs` - Basic arithmetic operations on collections
- `identity.rs` - Minimal overhead/passthrough operations
- `fan_in.rs` - Merging multiple collections
- `fan_out.rs` - Splitting collection to multiple consumers
- `micro_ops.rs` - Filter, map, and chained operations
- `reachability.rs` - Iterative graph traversal using differential's iteration

### 3. Documentation

- **README.md** - Comprehensive repository documentation
  - Repository purpose and structure
  - Getting started guide
  - Benchmark descriptions
  - Running instructions
  - Links to related resources

- **BENCHMARK_COMPARISON.md** - Detailed comparison guide
  - Framework comparison table
  - Running comparable benchmarks
  - Interpreting results
  - Advanced analysis techniques
  - Best practices and common pitfalls

- **QUICKSTART.md** - 5-minute quick start guide
  - Quick installation and setup
  - First benchmark run
  - Understanding output
  - Common tasks and troubleshooting

- **TESTING.md** - Testing and verification guide
  - Verification checklist
  - Individual benchmark tests
  - Performance regression testing
  - CI/CD integration examples

- **SETUP_NOTES.md** - This file, documenting what was created

### 4. Helper Scripts

- **run_all_benchmarks.sh** - Script to run all benchmarks with optional baseline
- **run_quick_benchmarks.sh** - Script for quick validation (subset of benchmarks)

### 5. Configuration Files

- **.gitignore** - Configured for Rust projects with Criterion benchmarks

## Benchmark Design Principles

### Comparable Structure
All benchmarks are designed to be comparable across frameworks:

1. **Similar workloads**: Same computational patterns in Timely, Differential, and (eventually) Hydro
2. **Multiple sizes**: Test with various input sizes to measure scaling characteristics
3. **Standard framework**: Using Criterion.rs for consistent measurement and reporting
4. **Clear naming**: Matching benchmark names across frameworks for easy comparison

### Performance Considerations

Each benchmark tests specific aspects:

- **Identity**: Framework overhead
- **Arithmetic**: Computational throughput
- **Fan-in/Fan-out**: Multi-stream coordination
- **Micro Ops**: Common operator performance
- **Reachability**: Iterative/fixpoint computation

## Dependencies

The repository depends on:

- **timely** (v0.12): Base timely dataflow framework
- **differential-dataflow** (v0.12): Incremental computation framework
- **criterion** (v0.5): Benchmarking harness with statistical analysis

## Verification Status

### ⚠️ Compilation Not Yet Verified

This repository was created in an environment without Rust/Cargo installed and without internet access to install them. Therefore:

- ✅ Structure is complete
- ✅ Code is syntactically sound (manual review)
- ⏳ Compilation verification pending
- ⏳ Benchmark execution pending

### Next Steps for Verification

1. **Install Rust**: If not already installed
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Verify Compilation**:
   ```bash
   cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
   cargo build --release
   ```

3. **Run Smoke Test**:
   ```bash
   cargo bench --bench identity -- --sample-size 10
   ```

4. **Run Full Test Suite**:
   ```bash
   ./run_all_benchmarks.sh initial-baseline
   ```

## Integration with Main Repository

### Dependency Separation Achieved

This repository maintains clean separation from the main repository:

- ✅ No circular dependencies
- ✅ Can be built independently
- ✅ Timely/Differential dependencies isolated here
- ✅ Main repository remains clean

### Cross-Repository Comparison

To compare with main repository:

1. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -- --save-baseline timely-differential
   ```

2. Run comparable benchmarks in main repository:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench  # or specific benchmark commands
   ```

3. Compare results manually or programmatically using the Criterion JSON output

See [BENCHMARK_COMPARISON.md](./BENCHMARK_COMPARISON.md) for detailed comparison instructions.

## File Permissions

Some files may need executable permissions:

```bash
chmod +x run_all_benchmarks.sh
chmod +x run_quick_benchmarks.sh
```

## Expected File Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                          # Workspace manifest
├── .gitignore                          # Git ignore rules
├── README.md                           # Main documentation
├── BENCHMARK_COMPARISON.md             # Comparison guide
├── QUICKSTART.md                       # Quick start guide
├── TESTING.md                          # Testing guide
├── SETUP_NOTES.md                      # This file
├── run_all_benchmarks.sh               # Full benchmark script
├── run_quick_benchmarks.sh             # Quick validation script
└── benches/
    ├── timely/
    │   ├── Cargo.toml                  # Timely package manifest
    │   └── benches/
    │       ├── arithmetic.rs
    │       ├── identity.rs
    │       ├── fan_in.rs
    │       ├── fan_out.rs
    │       ├── micro_ops.rs
    │       └── reachability.rs
    └── differential/
        ├── Cargo.toml                  # Differential package manifest
        └── benches/
            ├── arithmetic.rs
            ├── identity.rs
            ├── fan_in.rs
            ├── fan_out.rs
            ├── micro_ops.rs
            └── reachability.rs
```

## Known Limitations

### Timely Reachability
The Timely implementation uses a simplified approach without true iteration (which requires differential dataflow). This is intentional to show the difference between the frameworks.

### Sample Sizes
Default Criterion sample sizes (100) are used. For quicker testing, use `--sample-size 10`.

### Graph Sizes
Reachability benchmarks use relatively small graphs (100-1000 nodes) to keep benchmark times reasonable. For production workloads, larger graphs would be more representative.

## Future Enhancements

Potential additions:

1. **More benchmarks**: Join operations, aggregations, windowing
2. **Larger workloads**: Configurable sizes for stress testing
3. **Multi-worker**: Distributed execution benchmarks
4. **Memory profiling**: Integration with memory profilers
5. **Automated comparison**: Script to automatically compare with main repo
6. **CI/CD integration**: GitHub Actions workflow for automated benchmarking

## Maintenance Notes

### Updating Dependencies

To update Timely/Differential versions:

1. Edit `Cargo.toml` workspace dependencies
2. Run `cargo update`
3. Test all benchmarks
4. Update documentation if APIs changed

### Adding New Benchmarks

To add a new benchmark:

1. Create `benches/<framework>/benches/<name>.rs`
2. Add `[[bench]]` section to `benches/<framework>/Cargo.toml`
3. Implement using Criterion.rs
4. Document in README.md
5. Add to verification checklist in TESTING.md

## Contact and Support

For questions about this repository:

1. Review the documentation in this repository
2. Check the main repository: bigweaver-agent-canary-hydro-zeta
3. Refer to upstream documentation:
   - [Timely Dataflow](https://timelydataflow.github.io/timely-dataflow/)
   - [Differential Dataflow](https://timelydataflow.github.io/differential-dataflow/)
   - [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## Version History

- **Initial Setup**: Repository structure created with 12 benchmarks (6 Timely, 6 Differential)
- **Documentation**: Comprehensive documentation added (README, QUICKSTART, COMPARISON, TESTING)
- **Scripts**: Helper scripts for running benchmarks

## Checklist for First Use

- [ ] Verify Rust is installed (`rustc --version`)
- [ ] Verify Cargo is installed (`cargo --version`)
- [ ] Clone or access this repository
- [ ] Run `cargo build --release` to verify compilation
- [ ] Run `cargo bench --bench identity -- --sample-size 10` for smoke test
- [ ] Read QUICKSTART.md for next steps
- [ ] Run full benchmark suite if desired
- [ ] Compare with main repository as needed

---

Repository created and configured for performance comparison benchmarking.
