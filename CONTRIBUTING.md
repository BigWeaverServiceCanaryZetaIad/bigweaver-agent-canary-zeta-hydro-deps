# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the performance comparison benchmarks! This document provides guidelines and instructions for contributing.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development Setup](#development-setup)
3. [Adding Benchmarks](#adding-benchmarks)
4. [Testing Changes](#testing-changes)
5. [Submitting Changes](#submitting-changes)
6. [Code Standards](#code-standards)
7. [Benchmark Standards](#benchmark-standards)

## Getting Started

### Prerequisites

- Rust toolchain (edition 2024 or later)
- Git
- Familiarity with Criterion.rs benchmarking framework
- Understanding of dataflow programming concepts

### Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                  # Benchmark package
│   ├── Cargo.toml           # Dependencies
│   ├── README.md            # Benchmark documentation
│   ├── build.rs             # Build script
│   └── benches/             # Benchmark implementations
├── Cargo.toml               # Workspace configuration
├── README.md                # Repository overview
├── TESTING_GUIDE.md         # Testing instructions
├── CHANGELOG.md             # Version history
└── CONTRIBUTING.md          # This file
```

## Development Setup

### Clone and Build

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build
cargo build -p benches

# Run tests (if any)
cargo test -p benches

# Run benchmarks to verify
cargo bench -p benches --no-run
```

### Local Development with Main Repository

For faster iteration with local changes to dfir_rs:

```bash
# Create cargo patch configuration
mkdir -p .cargo
cat > .cargo/config.toml << 'EOF'
[patch."https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git"]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
EOF
```

### Development Tools

Install recommended tools:

```bash
# Clippy for linting
rustup component add clippy

# Rustfmt for formatting
rustup component add rustfmt

# Cargo-edit for dependency management
cargo install cargo-edit
```

## Adding Benchmarks

### Benchmark Structure

Create a new benchmark file in `benches/benches/`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

// Constants
const DATA_SIZE: usize = 10_000;

// Baseline implementation (if applicable)
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("my_bench/baseline", |b| {
        b.iter(|| {
            // Minimal overhead implementation
            let data: Vec<_> = (0..DATA_SIZE).collect();
            for item in data {
                black_box(item);
            }
        });
    });
}

// Timely implementation
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_bench/timely", |b| {
        b.iter(|| {
            use timely::dataflow::operators::*;
            
            let receiver = timely::example(|scope| {
                (0..DATA_SIZE)
                    .to_stream(scope)
                    .capture()
            });
            
            for item in receiver {
                black_box(item);
            }
        });
    });
}

// dfir_rs implementation
fn benchmark_dfir_rs(c: &mut Criterion) {
    c.bench_function("my_bench/dfir_rs", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(0..DATA_SIZE) 
                    -> for_each(|x| { black_box(x); });
            };
            df.run_available_sync();
        });
    });
}

criterion_group!(benches, benchmark_baseline, benchmark_timely, benchmark_dfir_rs);
criterion_main!(benches);
```

### Register the Benchmark

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### Document the Benchmark

Add documentation to `benches/README.md`:

```markdown
### My Benchmark
**File**: `my_benchmark.rs`

Description of what this benchmark measures.

**Variants**:
- `my_bench/baseline` - Baseline implementation
- `my_bench/timely` - Timely dataflow implementation
- `my_bench/dfir_rs` - dfir_rs implementation

**Run**:
\`\`\`bash
cargo bench -p benches --bench my_benchmark
\`\`\`
```

### Update CHANGELOG

Add entry to `CHANGELOG.md`:

```markdown
### Added
- New benchmark: my_benchmark - Description of what it measures
```

## Testing Changes

### Verify Compilation

```bash
# Build benchmarks
cargo build -p benches

# Check for warnings
cargo clippy -p benches

# Format code
cargo fmt -p benches
```

### Run Benchmarks

```bash
# Quick verification
cargo bench -p benches --bench my_benchmark -- --quick

# Full benchmark
cargo bench -p benches --bench my_benchmark

# Verify all benchmarks still work
cargo bench -p benches --no-run
```

### Validate Results

Ensure:
1. All implementations produce identical results
2. Benchmarks complete without errors
3. Statistical analysis shows reasonable variance
4. No unexpected performance characteristics

### Check Documentation

Verify documentation:
```bash
# Check for broken links
# Check formatting
# Ensure examples are accurate
```

## Submitting Changes

### Before Submitting

Checklist:
- [ ] Code compiles without warnings
- [ ] Benchmarks run successfully
- [ ] Code is formatted (`cargo fmt`)
- [ ] Code passes clippy (`cargo clippy`)
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated
- [ ] Commit messages follow conventions

### Commit Messages

Follow the Conventional Commits specification:

```
type(scope): description

[optional body]

[optional footer]
```

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Maintenance tasks

**Examples**:
```
feat(benches): add graph traversal benchmark

Implements breadth-first and depth-first graph traversal benchmarks
comparing timely, differential, and dfir_rs implementations.

- Added bfs.rs with multiple variants
- Added test graph data
- Updated documentation
```

```
fix(reachability): correct edge data loading

The edge data was being loaded incorrectly, causing assertion failures.
Fixed the loading logic and verified results match expected output.

Fixes #123
```

### Pull Request Process

1. **Fork the repository**
   ```bash
   # Fork on GitHub, then:
   git clone https://github.com/YOUR_USERNAME/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   git remote add upstream https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feat/my-benchmark
   ```

3. **Make changes and commit**
   ```bash
   git add .
   git commit -m "feat(benches): add my benchmark"
   ```

4. **Push and create PR**
   ```bash
   git push origin feat/my-benchmark
   # Create pull request on GitHub
   ```

5. **PR Description Template**
   ```markdown
   ## Overview
   Brief description of the changes
   
   ## Task Details
   - ✅ Added new benchmark: my_benchmark
   - ✅ Updated documentation
   - ✅ Added test data
   
   ## Changes Made
   - Added `benches/benches/my_benchmark.rs`
   - Updated `benches/README.md`
   - Updated `CHANGELOG.md`
   - Added test data files
   
   ## Benefits
   - ✅ Enables performance comparison for [feature]
   - ✅ Provides baseline for [optimization]
   - ✅ Comprehensive documentation
   
   ## Testing
   - ✅ Benchmarks compile successfully
   - ✅ All implementations produce correct results
   - ✅ Quick benchmarks complete in reasonable time
   - ✅ Documentation is accurate
   
   ## Available Benchmarks
   - `my_benchmark/baseline` - Baseline implementation
   - `my_benchmark/timely` - Timely implementation
   - `my_benchmark/dfir_rs` - dfir_rs implementation
   ```

## Code Standards

### Rust Style

Follow the Rust style guidelines:
- Use `rustfmt` for formatting
- Follow clippy suggestions
- Use meaningful variable names
- Add comments for complex logic
- Keep functions focused and small

### Benchmark-Specific Standards

#### Use black_box

Prevent compiler optimization:
```rust
use criterion::black_box;

// Good
for item in data {
    black_box(item);
}

// Bad - may be optimized away
for item in data {
    let _ = item;
}
```

#### Fair Comparisons

Ensure all implementations solve the same problem:
```rust
// Good - all implementations use same data
let data: Vec<_> = (0..SIZE).collect();
benchmark_timely(&data);
benchmark_dfir_rs(&data);

// Bad - different data
benchmark_timely(&(0..SIZE).collect());
benchmark_dfir_rs(&(0..SIZE*2).collect());
```

#### Realistic Data

Use representative data:
```rust
// Good - realistic distribution
use rand::distributions::Uniform;
let dist = Uniform::new(0, 100);
let data: Vec<_> = (0..SIZE).map(|_| dist.sample(&mut rng)).collect();

// Questionable - unrealistic pattern
let data: Vec<_> = (0..SIZE).collect();
```

### Documentation Standards

#### Benchmark Documentation

Every benchmark should document:
1. **Purpose**: What is being measured?
2. **Variants**: What implementations are compared?
3. **Data**: What data is used?
4. **Usage**: How to run the benchmark?
5. **Interpretation**: What do results indicate?

#### Code Comments

```rust
// Good - explains why
// Use BTreeMap instead of HashMap for deterministic iteration
let mut map = BTreeMap::new();

// Bad - explains what (obvious from code)
// Create a new BTreeMap
let mut map = BTreeMap::new();
```

## Benchmark Standards

### Performance Characteristics

Benchmarks should:
1. **Complete in reasonable time**: < 5 minutes for full run
2. **Have low variance**: Consistent measurements
3. **Be reproducible**: Same results on repeated runs
4. **Scale appropriately**: Data sizes match real workloads

### Statistical Rigor

Use appropriate sample sizes:
```rust
// For fast operations (< 1ms)
c.bench_function("fast_op", |b| {
    b.iter(|| { /* fast operation */ });
});  // Default sample size is appropriate

// For slow operations (> 100ms)
use criterion::BenchmarkId;
c.bench_with_input(BenchmarkId::new("slow_op", "large"), &data, |b, data| {
    b.iter(|| { /* slow operation */ });
}).sample_size(10);  // Reduce sample size
```

### Correctness Validation

Include assertions:
```rust
fn benchmark_with_validation(c: &mut Criterion) {
    c.bench_function("my_bench/dfir_rs", |b| {
        b.iter(|| {
            let result = compute_something();
            assert_eq!(result, EXPECTED_RESULT);
            black_box(result)
        });
    });
}
```

### Data Management

#### Small Data
Include directly in benchmark code:
```rust
const TEST_DATA: &[u8] = &[1, 2, 3, 4, 5];
```

#### Large Data
Store in separate files:
```rust
static DATA: LazyLock<Vec<u8>> = LazyLock::new(|| {
    let path = PathBuf::from_iter([env!("CARGO_MANIFEST_DIR"), "benches", "data.txt"]);
    std::fs::read(&path).unwrap()
});
```

## Review Process

### What Reviewers Look For

1. **Correctness**
   - Do all implementations produce identical results?
   - Are assertions present and meaningful?
   - Is the benchmark measuring what it claims?

2. **Fairness**
   - Do all implementations solve the same problem?
   - Is setup time excluded from measurements?
   - Are inputs identical across implementations?

3. **Documentation**
   - Is the purpose clearly explained?
   - Are usage examples provided?
   - Is interpretation guidance included?

4. **Code Quality**
   - Is code formatted correctly?
   - Does it pass clippy?
   - Are variable names meaningful?

5. **Performance**
   - Do benchmarks complete in reasonable time?
   - Is variance acceptably low?
   - Are results interpretable?

### Addressing Feedback

Respond to review comments:
```bash
# Make changes
git add .
git commit -m "fix: address review feedback"
git push origin feat/my-benchmark
```

## Getting Help

### Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)
- Repository `README.md` and `TESTING_GUIDE.md`

### Questions

For questions:
1. Check existing documentation
2. Review similar benchmarks
3. Search for related issues
4. Open a discussion on GitHub

### Reporting Issues

When reporting issues:
1. Describe the problem clearly
2. Provide reproduction steps
3. Include system information
4. Share relevant code snippets
5. Describe expected vs actual behavior

## Thank You!

Your contributions help improve performance comparison capabilities and enable data-driven optimization decisions. We appreciate your time and effort!
