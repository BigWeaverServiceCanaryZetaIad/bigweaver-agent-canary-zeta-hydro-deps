# Contributing to bigweaver-agent-canary-zeta-hydro-deps

## Welcome!

Thank you for your interest in contributing to the bigweaver-agent-canary-zeta-hydro-deps benchmark repository. This document provides guidelines for contributing benchmarks, documentation, and improvements.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Types of Contributions](#types-of-contributions)
3. [Adding New Benchmarks](#adding-new-benchmarks)
4. [Improving Documentation](#improving-documentation)
5. [Code Standards](#code-standards)
6. [Testing Guidelines](#testing-guidelines)
7. [Pull Request Process](#pull-request-process)
8. [Review Criteria](#review-criteria)

## Getting Started

### Prerequisites

Before contributing, ensure you have:

1. **Repository setup**: Both repositories cloned and working
   ```bash
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. **Rust toolchain**: Matching version from main repository
   ```bash
   rustc --version
   cargo --version
   ```

3. **Working benchmarks**: Verification passes
   ```bash
   ./verify_benchmarks.sh
   ```

### Development Environment

1. **Clone repositories**:
   ```bash
   cd /projects/sandbox
   git clone <url> bigweaver-agent-canary-hydro-zeta
   git clone <url> bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify setup**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ./verify_benchmarks.sh
   ```

3. **Build benchmarks**:
   ```bash
   cd benches
   cargo build --release --benches
   ```

## Types of Contributions

### 1. New Benchmarks

Add benchmarks that:
- Compare dfir_rs with timely/differential-dataflow
- Test important dataflow patterns
- Provide meaningful performance insights
- Include proper documentation

### 2. Benchmark Improvements

Enhance existing benchmarks:
- Add more test scenarios
- Improve measurement accuracy
- Optimize benchmark code
- Fix bugs or issues

### 3. Documentation

Improve documentation:
- Fix typos or errors
- Add clarifications
- Include examples
- Update guides

### 4. Tooling

Enhance scripts and tools:
- Improve verification scripts
- Add comparison tools
- Create analysis utilities
- Automate common tasks

### 5. Test Data

Contribute test data:
- Real-world datasets
- Edge case scenarios
- Performance stress tests
- Correctness validation data

## Adding New Benchmarks

### Step-by-Step Process

#### 1. Plan Your Benchmark

**Define objectives**:
- What are you measuring?
- Why is this important?
- What frameworks will you compare?

**Design test cases**:
- What scenarios will you test?
- What data sizes are relevant?
- What metrics matter?

#### 2. Create Benchmark File

Create `benches/benches/my_benchmark.rs`:

```rust
use criterion::{criterion_group, criterion_main, Criterion, black_box};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Map, Inspect};

// Define test parameters
const TEST_SIZE: usize = 10_000;

// Benchmark function
fn benchmark_operation(c: &mut Criterion) {
    c.bench_function("my_benchmark/operation", |b| {
        b.iter(|| {
            // Setup (not measured)
            let data: Vec<i32> = (0..TEST_SIZE).collect();
            
            // Code to benchmark (measured)
            black_box({
                // Your benchmark code here
            });
        });
    });
}

criterion_group!(benches, benchmark_operation);
criterion_main!(benches);
```

#### 3. Add Configuration

Update `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

#### 4. Add Test Data (if needed)

```bash
# Add data files to benches/benches/
cp my_test_data.txt benches/benches/
```

#### 5. Update Documentation

Update these files:
- `BENCHMARKS.md` - Add detailed description
- `README.md` - Add to benchmark list
- `MANIFEST.md` - Add file listing
- `verify_benchmarks.sh` - Add verification

#### 6. Test Your Benchmark

```bash
# Build
cargo build --release --bench my_benchmark

# Run
cargo bench --bench my_benchmark

# Verify
./verify_benchmarks.sh
```

### Benchmark Best Practices

#### Do's ✅

1. **Use black_box()** to prevent optimization:
   ```rust
   black_box(expensive_operation())
   ```

2. **Separate setup from measurement**:
   ```rust
   b.iter(|| {
       // Setup here (not measured in some iter modes)
       let data = setup_data();
       
       // Measure this
       black_box(process(data))
   });
   ```

3. **Test multiple scenarios**:
   ```rust
   for size in [100, 1000, 10000] {
       c.bench_function(&format!("op/size_{}", size), |b| {
           // Benchmark with different size
       });
   }
   ```

4. **Verify correctness**:
   ```rust
   let result = operation();
   assert_eq!(result, expected);
   ```

5. **Document thoroughly**:
   ```rust
   /// Benchmarks join operation performance.
   /// 
   /// Tests:
   /// - Small datasets (100 elements)
   /// - Large datasets (1M elements)
   /// 
   /// Compares dfir_rs with timely implementations.
   ```

#### Don'ts ❌

1. **Don't include I/O in measurements** (unless testing I/O):
   ```rust
   // Bad: I/O in measured section
   b.iter(|| {
       let data = read_from_file(); // Measured!
       process(data)
   });
   
   // Good: I/O outside measured section
   let data = read_from_file();
   b.iter(|| {
       process(data.clone()) // Only this is measured
   });
   ```

2. **Don't use println!() in benchmarks**:
   ```rust
   // Bad
   b.iter(|| {
       println!("Processing..."); // Affects timing
       process()
   });
   
   // Good: Use Inspect for debugging, remove for final
   ```

3. **Don't assume specific hardware**:
   ```rust
   // Bad
   const THREADS: usize = 16; // Assumes 16 cores
   
   // Good
   let threads = num_cpus::get();
   ```

4. **Don't test trivial operations**:
   - Must provide meaningful insights
   - Should test realistic scenarios
   - Need to justify benchmark existence

## Improving Documentation

### Documentation Standards

#### Style Guidelines

1. **Clear and concise**: Get to the point
2. **Use examples**: Show, don't just tell
3. **Consistent formatting**: Follow existing patterns
4. **Proper structure**: Use headings and sections
5. **Complete information**: Include all necessary details

#### Required Sections

For benchmark documentation:

1. **Purpose**: What does this benchmark measure?
2. **Methodology**: How does it measure?
3. **Test cases**: What scenarios are tested?
4. **Dependencies**: What frameworks are used?
5. **Usage**: How to run it?
6. **Interpretation**: How to understand results?

#### Example Documentation

````markdown
### My Benchmark (`my_benchmark.rs`)

**Purpose**: Measure performance of operation X across different implementations.

**Test Cases**:
- Small datasets (100 elements)
- Large datasets (1M elements)
- Skewed distributions

**Dependencies**: timely, differential-dataflow

**Usage**:
```bash
cargo bench --bench my_benchmark
```

**Example Output**:
```
my_benchmark/small      time: [1.23 µs 1.25 µs 1.27 µs]
my_benchmark/large      time: [12.3 ms 12.5 ms 12.7 ms]
```

**Interpretation**:
- Small datasets: Linear time complexity
- Large datasets: O(n log n) behavior observed
- Memory usage: Constant overhead + O(n)
````

## Code Standards

### Rust Style

Follow Rust conventions:

```rust
// Good naming
fn benchmark_hash_join(c: &mut Criterion) { }

// Good structure
const TEST_SIZE: usize = 10_000;
const NUM_ITERATIONS: usize = 100;

// Good documentation
/// Benchmarks hash join with various input sizes.
/// 
/// # Test Cases
/// - Equal sized inputs
/// - Skewed inputs (1:1000 ratio)
```

### Criterion Usage

Standard Criterion patterns:

```rust
use criterion::{criterion_group, criterion_main, Criterion, black_box};

fn my_benchmark(c: &mut Criterion) {
    // Single benchmark
    c.bench_function("name", |b| {
        b.iter(|| black_box(operation()));
    });
    
    // Parameterized benchmark
    for size in [100, 1000, 10000] {
        c.bench_function(&format!("name/{}", size), |b| {
            b.iter(|| black_box(operation_with_size(size)));
        });
    }
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

## Testing Guidelines

### Before Submitting

1. **Build succeeds**:
   ```bash
   cargo build --release --benches
   ```

2. **Benchmarks run**:
   ```bash
   cargo bench --bench my_benchmark
   ```

3. **Verification passes**:
   ```bash
   ./verify_benchmarks.sh
   ```

4. **Results make sense**:
   - Check output for reasonableness
   - Verify statistical quality
   - Compare with expectations

### Verification Checklist

- [ ] Code compiles without warnings
- [ ] Benchmarks run successfully
- [ ] Results are reproducible
- [ ] Documentation is complete
- [ ] Test data is included (if needed)
- [ ] Verification script updated
- [ ] MANIFEST.md updated

## Pull Request Process

### 1. Prepare Your Changes

```bash
# Create feature branch
git checkout -b add-my-benchmark

# Make your changes
# ...

# Test thoroughly
./verify_benchmarks.sh
cargo bench --bench my_benchmark

# Commit with clear message
git commit -m "feat(benches): add my_benchmark for X operation"
```

### 2. Update Documentation

Ensure these are updated:
- [ ] README.md (if adding benchmarks)
- [ ] BENCHMARKS.md (detailed description)
- [ ] MANIFEST.md (file listing)
- [ ] CONTRIBUTING.md (if changing process)

### 3. Submit Pull Request

**Title format**:
```
feat(scope): brief description
```

Examples:
- `feat(benches): add hash join benchmark`
- `docs(readme): clarify setup instructions`
- `fix(benchmarks): correct reachability verification`

**Description should include**:
- What: What changes were made?
- Why: Why are these changes needed?
- How: How do the changes work?
- Testing: How were changes tested?
- Impact: What's the impact on users?

**Template**:
```markdown
## Overview
Brief description of changes.

## Changes Made
- Added X benchmark
- Updated Y documentation
- Fixed Z issue

## Testing
- Ran verification script: ✅
- Ran new benchmarks: ✅
- Checked results: ✅

## Documentation Updated
- [ ] README.md
- [ ] BENCHMARKS.md
- [ ] MANIFEST.md
```

### 4. Address Review Feedback

- Respond to comments promptly
- Make requested changes
- Re-test after changes
- Update PR description if needed

## Review Criteria

Pull requests will be reviewed for:

### Code Quality
- [ ] Follows Rust conventions
- [ ] Uses Criterion properly
- [ ] Includes proper error handling
- [ ] No unnecessary complexity

### Benchmark Quality
- [ ] Measures meaningful operations
- [ ] Uses appropriate test data
- [ ] Avoids common pitfalls
- [ ] Produces reliable results

### Documentation Quality
- [ ] Clear and complete
- [ ] Follows existing patterns
- [ ] Includes examples
- [ ] No typos or errors

### Testing
- [ ] Builds successfully
- [ ] Runs without errors
- [ ] Verification passes
- [ ] Results are reasonable

### Impact
- [ ] Adds value to repository
- [ ] Doesn't break existing functionality
- [ ] Maintains consistency
- [ ] Follows team preferences

## Questions or Issues?

If you have questions:

1. Check existing documentation (README.md, BENCHMARKS.md)
2. Review similar benchmarks
3. Run verification script
4. Open an issue for clarification

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Thank You!

Your contributions help make this benchmark suite better for everyone. We appreciate your time and effort! 🎉
