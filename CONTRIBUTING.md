# Contributing to Hydro Benchmarks (External Dependencies)

This repository contains benchmarks for Hydro that compare performance against external dataflow frameworks, specifically `timely-dataflow` and `differential-dataflow`.

## Purpose and Scope

This repository serves a specific purpose in the Hydro ecosystem:

### ✅ What Belongs Here
- Benchmarks comparing Hydro against timely-dataflow
- Benchmarks comparing Hydro against differential-dataflow
- Performance tests requiring these external dependencies
- Data files needed by comparison benchmarks

### ❌ What Belongs in Main Repository
- Benchmarks that only test Hydro/DFIR features
- Benchmarks not requiring timely/differential dependencies
- Core functionality tests
- Feature development

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md              # Repository overview and quick start
├── CONTRIBUTING.md        # This file - contribution guidelines
├── Cargo.toml            # Workspace configuration
└── benches/              # Benchmark package
    ├── Cargo.toml        # Dependencies and benchmark declarations
    ├── build.rs          # Build-time code generation
    ├── README.md         # Detailed benchmark documentation
    └── benches/          # Benchmark implementations
        ├── *.rs          # Individual benchmark files
        └── *.txt         # Data files for benchmarks
```

### Directory Details

* **`benches/`** - Contains all benchmark code and data
  * **`benches/benches/`** - Individual benchmark implementations
  * **`benches/Cargo.toml`** - Package configuration with all dependencies
  * **`benches/build.rs`** - Build script for generating benchmark code
  * **`benches/README.md`** - Comprehensive benchmark documentation

## Benchmarks Overview

### Performance Comparison Benchmarks

Each benchmark is designed to compare equivalent operations across different frameworks:

#### arithmetic
**Purpose:** Sequential map operations performance  
**Frameworks:** Timely, Hydroflow (compiled/surface), raw pipelines, iterators  
**Workload:** 20 map operations on 1,000,000 integers  
**Insights:** Operator chaining efficiency and overhead

#### fan_in
**Purpose:** Multiple input stream merging  
**Frameworks:** Timely, Hydroflow  
**Workload:** Multiple sources concatenating to single output  
**Insights:** Stream merging and synchronization

#### fan_out
**Purpose:** Single stream distribution  
**Frameworks:** Timely, Hydroflow  
**Workload:** One source splitting to multiple sinks  
**Insights:** Stream duplication and routing

#### fork_join
**Purpose:** Fork-join patterns with filtering  
**Frameworks:** Timely, Hydroflow  
**Workload:** 20 levels of split, filter (even/odd), and merge  
**Insights:** Complex dataflow graphs, conditional routing

#### identity
**Purpose:** Framework overhead measurement  
**Frameworks:** Timely, Hydroflow, raw implementations  
**Workload:** No-op transformations  
**Insights:** Baseline performance costs

#### join
**Purpose:** Hash join operations  
**Frameworks:** Timely, Hydroflow  
**Workload:** 100,000 key-value pairs, various types (`usize`, `String`)  
**Insights:** Relational operator performance

#### reachability
**Purpose:** Graph iterative computation  
**Frameworks:** Differential-dataflow, Hydroflow  
**Workload:** Transitive closure on real graph data  
**Insights:** Iterative and incremental computation  
**Data Files:** `reachability_edges.txt`, `reachability_reachable.txt`

#### upcase
**Purpose:** String transformation  
**Frameworks:** Timely, Hydroflow  
**Workload:** Uppercase conversion on word list  
**Insights:** String processing in dataflow context  
**Data Files:** `words_alpha.txt`

## Running Benchmarks

### Basic Usage

Run all benchmarks:
```bash
cargo bench -p hydro-timely-differential-benches
```

Run specific benchmark:
```bash
cargo bench -p hydro-timely-differential-benches --bench <name>
# Examples:
cargo bench -p hydro-timely-differential-benches --bench reachability
cargo bench -p hydro-timely-differential-benches --bench arithmetic
cargo bench -p hydro-timely-differential-benches --bench identity
```

### Advanced Options

Run specific benchmark function:
```bash
# Filter by function name
cargo bench -p hydro-timely-differential-benches --bench arithmetic -- "timely"
cargo bench -p hydro-timely-differential-benches --bench join -- "usize/usize"
```

Control sample size:
```bash
# Run with fewer samples (faster but less accurate)
cargo bench -p hydro-timely-differential-benches -- --sample-size 10
```

Generate HTML reports:
```bash
cargo bench -p hydro-timely-differential-benches -- --noplot
# Reports generated in: ../../target/criterion/
```

Profile benchmarks:
```bash
# Build with profiling information
cargo bench -p hydro-timely-differential-benches --profile profile -- --profile-time=5
```

### Interpreting Results

Criterion provides statistical analysis:
- **Mean** - Average execution time
- **Std Dev** - Measurement variability
- **Median** - Middle value (less affected by outliers)
- **Change** - Comparison to previous run (if available)

**Performance indicators:**
- Lower mean execution time = better performance
- Lower std dev = more consistent performance
- Positive change % = performance regression
- Negative change % = performance improvement

## Dependencies

### External Framework Dependencies

These are the core reason for this separate repository:

```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

**Note:** Using development versions to track upstream changes.

### Hydro Dependencies (Path Dependencies)

The benchmarks depend on the main Hydro repository:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

**Repository layout requirement:**
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/       # Main repo must be here
│   ├── dfir_rs/
│   └── sinktools/
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repo
    └── benches/
```

### Testing and Utility Dependencies

```toml
criterion = { version = "0.5.0", features = ["async_tokio", "html_reports"] }
tokio = { version = "1.29.0", features = ["rt-multi-thread"] }
futures = "0.3"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
nameof = "1.0.0"
static_assertions = "1.0.0"
```

## Adding New Benchmarks

### Step 1: Create Benchmark File

Create `benches/benches/my_benchmark.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Map, Inspect};

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter_batched(
            || {
                dfir_syntax! {
                    source_iter(0..1000)
                        -> map(|x| x * 2)
                        -> for_each(|x| { black_box(x); });
                }
            },
            |mut df| {
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..1000)
                    .to_stream(scope)
                    .map(|x| x * 2)
                    .inspect(|x| { black_box(x); });
            });
        })
    });
}

criterion_group!(my_benchmark_group, benchmark_hydroflow, benchmark_timely);
criterion_main!(my_benchmark_group);
```

### Step 2: Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Step 3: Add Dependencies (if needed)

If your benchmark needs additional dependencies, add them to `[dev-dependencies]` in `benches/Cargo.toml`.

### Step 4: Document the Benchmark

Add documentation to `benches/README.md`:
- Benchmark purpose and description
- What it measures
- Expected results
- Data files (if any)

### Step 5: Test the Benchmark

```bash
# Ensure it compiles
cargo build -p hydro-timely-differential-benches --benches

# Run the benchmark
cargo bench -p hydro-timely-differential-benches --bench my_benchmark

# Verify results make sense
```

## Updating Benchmarks

When updating existing benchmarks:

### API Changes in Main Repository

1. Update benchmark code to match new APIs
2. Test compilation: `cargo build -p hydro-timely-differential-benches --benches`
3. Run benchmarks to verify correctness
4. Document API changes in commit message

### Performance Improvements

When making changes that should improve performance:

1. Run baseline benchmark: `cargo bench -p hydro-timely-differential-benches --bench <name>`
2. Make changes
3. Run benchmark again to compare
4. Criterion will show percentage change
5. Document improvements in commit/PR

### Adding Framework Comparisons

When adding new framework comparisons to existing benchmarks:

1. Implement the comparison function
2. Add to `criterion_group!` macro
3. Update benchmark documentation
4. Verify all comparisons produce equivalent results

## Build Script (build.rs)

The `build.rs` script generates code at compile time:

### Current Functionality

Generates `fork_join_20.hf` file with Hydroflow syntax for the fork-join benchmark:
- Creates 20 levels of fork-join operations
- Generates filtering and union operations
- Used by `benches/fork_join.rs`

### Modifying Build Script

If you need to generate additional code:

1. Edit `benches/build.rs`
2. Add new generation function
3. Call from `main()`
4. Reference generated code in benchmark
5. Document the generated code purpose

Example:
```rust
pub fn my_generation() -> std::io::Result<()> {
    let path = PathBuf::from_iter([
        env!("CARGO_MANIFEST_DIR"),
        "benches",
        "my_generated.hf",
    ]);
    let file = File::create(path)?;
    let mut write = BufWriter::new(file);
    
    // Generate code...
    writeln!(write, "dfir_syntax! {{")?;
    // ...
    
    write.flush()?;
    Ok(())
}
```

## Data Files

### Current Data Files

Located in `benches/benches/`:

- **reachability_edges.txt** (~520 KB)
  - Graph edges: `source_node target_node`
  - Used by: reachability benchmark
  
- **reachability_reachable.txt** (~38 KB)
  - Expected reachable nodes (one per line)
  - Used by: reachability benchmark validation
  
- **words_alpha.txt** (~3.7 MB)
  - English word list
  - Source: https://github.com/dwyl/english-words
  - Used by: upcase benchmark

### Adding Data Files

If your benchmark needs data files:

1. **Include in binary:** Use `include_bytes!` or `include_str!`
   ```rust
   static DATA: LazyLock<Vec<String>> = LazyLock::new(|| {
       let cursor = Cursor::new(include_bytes!("my_data.txt"));
       // Parse data...
   });
   ```

2. **Place in benches/benches/** directory alongside benchmark code

3. **Document in README:** Add description to data files section

4. **Keep reasonable size:** Large files (>10 MB) should be justified

5. **Provide source:** Document where data comes from

## Testing Changes

### Before Committing

1. **Build check:**
   ```bash
   cargo build -p hydro-timely-differential-benches --benches
   ```

2. **Run benchmarks:**
   ```bash
   cargo bench -p hydro-timely-differential-benches
   ```

3. **Check main repo compatibility:**
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo test -p dfir_rs
   cargo test -p sinktools
   ```

4. **Verify documentation:**
   - README.md updated?
   - CONTRIBUTING.md updated (if process changes)?
   - Code comments for complex logic?

## Code Style

### Follow Existing Patterns

- Use Criterion for all benchmarks
- Include multiple framework comparisons where possible
- Use `black_box()` to prevent compiler optimizations
- Follow Rust naming conventions

### Benchmark Structure

```rust
// 1. Imports
use criterion::{Criterion, black_box, criterion_group, criterion_main};

// 2. Constants
const WORKLOAD_SIZE: usize = 1_000_000;

// 3. Benchmark functions
fn benchmark_framework_a(c: &mut Criterion) { /* ... */ }
fn benchmark_framework_b(c: &mut Criterion) { /* ... */ }

// 4. Criterion group and main
criterion_group!(benchmark_name, benchmark_framework_a, benchmark_framework_b);
criterion_main!(benchmark_name);
```

### Error Handling

- Use `unwrap()` in benchmark code (failures should panic)
- Use `?` in build script (build errors should be visible)
- Include assertions for data validation

## Common Issues

### Path Dependency Errors

**Problem:** `error: failed to load manifest for dependency 'dfir_rs'`

**Solution:**
```bash
# Verify directory structure
ls -la ../bigweaver-agent-canary-hydro-zeta/dfir_rs/Cargo.toml
ls -la ../bigweaver-agent-canary-hydro-zeta/sinktools/Cargo.toml
```

### Slow Benchmark Execution

**Problem:** Benchmarks take too long

**Solutions:**
- Reduce workload size in constants
- Run specific benchmarks only
- Use `--sample-size` to reduce iterations
- Close resource-intensive applications

### Inconsistent Results

**Problem:** High variance in benchmark results

**Solutions:**
- Ensure consistent system state (close background apps)
- Run with higher sample size for more stable results
- Check for thermal throttling
- Use `--warm-up-time` to stabilize before measurement

### Build Script Issues

**Problem:** Generated files not found

**Solution:**
- Ensure `build.rs` runs successfully
- Check `OUT_DIR` or generated file paths
- Verify file is created before benchmark compilation

## Workflow Best Practices

### Development Workflow

1. Make changes in main repository (if needed)
2. Update benchmark code in this repository
3. Build and test: `cargo build --benches && cargo bench`
4. Document changes
5. Commit with descriptive message

### Cross-Repository Changes

When changes span both repositories:

1. **Main repo first:** Make changes to `dfir_rs` or `sinktools`
2. **Test main repo:** Ensure all tests pass
3. **Update benchmarks:** Adapt to API changes
4. **Test benchmarks:** Verify they still work
5. **Coordinate:** Both changes should be compatible

### Commit Messages

Follow conventional commits format:

```
feat(benchmark-name): add new comparison benchmark
fix(reachability): correct edge parsing logic
docs(readme): update benchmark descriptions
perf(join): optimize hash table initialization
```

## Documentation Standards

### Code Comments

- Explain **why**, not **what** (code shows what)
- Document non-obvious performance considerations
- Clarify framework-specific quirks
- Reference external resources when relevant

### Benchmark Documentation

Each benchmark should document:
- **Purpose** - What does it measure?
- **Frameworks** - Which frameworks are compared?
- **Workload** - What is the input/operation?
- **Insights** - What does it reveal about performance?
- **Data files** - What data files does it use?

### README Updates

When adding/changing benchmarks:
- Update main README.md with high-level overview
- Update benches/README.md with detailed information
- Keep both files in sync regarding basic information
- Document any new dependencies

## Questions or Issues?

For questions about:
- **Hydro/DFIR APIs:** Refer to main repository documentation
- **Benchmark design:** Check existing benchmarks for patterns
- **Criterion usage:** See [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)
- **Timely/Differential:** See their respective repositories and documentation

## References

- [Hydro Project Documentation](https://hydro.run/)
- [Criterion.rs Benchmarking Guide](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
