# Relationship to Main Repository

This document explains the relationship between `bigweaver-agent-canary-zeta-hydro-deps` (this repository) and `bigweaver-agent-canary-hydro-zeta` (the main repository).

## Overview

These repositories work together to provide comprehensive performance benchmarking capabilities while maintaining clean architecture and minimal dependencies.

```
┌─────────────────────────────────────────────────────────────────┐
│         bigweaver-agent-canary-hydro-zeta (Main Repo)           │
│                                                                 │
│  - Core Hydroflow/DFIR implementation                          │
│  - Application code and libraries                               │
│  - Hydroflow/DFIR benchmarks                                    │
│  - Documentation and examples                                   │
│                                                                 │
│  Dependencies: Core Rust ecosystem only                         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Performance
                              │ Comparison
                              │
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│    bigweaver-agent-canary-zeta-hydro-deps (This Repo)          │
│                                                                 │
│  - Timely Dataflow benchmarks                                   │
│  - Differential-Dataflow benchmarks                             │
│  - Performance comparison tools                                 │
│  - Comparison documentation                                     │
│                                                                 │
│  Dependencies: Timely + Differential-Dataflow                   │
└─────────────────────────────────────────────────────────────────┘
```

## Repository Separation Rationale

### Why Two Repositories?

The benchmarks were intentionally separated into two repositories for several strategic reasons:

#### 1. **Dependency Management**

**Problem**: Including timely and differential-dataflow in the main repository added significant dependencies that weren't needed for core functionality.

**Solution**: Separate repository keeps the main codebase lean and focused.

**Benefits**:
- Faster compilation of main repository
- Smaller dependency tree for end users
- Easier maintenance and security updates
- Reduced binary size for production deployments

#### 2. **Separation of Concerns**

**Problem**: Mixing comparison benchmarks with core functionality blurs architectural boundaries.

**Solution**: Clear separation between core implementation and external framework comparisons.

**Benefits**:
- Main repository focuses on Hydroflow/DFIR
- Deps repository focuses on external framework evaluation
- Clear ownership and maintenance responsibilities
- Independent evolution of each codebase

#### 3. **Architectural Clarity**

**Problem**: Having benchmarks for external frameworks in the main repo suggests they're required dependencies.

**Solution**: Separate repository makes it clear these are optional comparison tools.

**Benefits**:
- Users understand core vs. comparison dependencies
- No confusion about what's required vs. optional
- Clear boundaries for project scope
- Better documentation organization

#### 4. **Development Workflow**

**Problem**: Changes to comparison benchmarks shouldn't trigger full CI/CD in main repository.

**Solution**: Independent repositories with independent workflows.

**Benefits**:
- Faster CI/CD for main repository changes
- Comparison benchmarks can evolve independently
- No need to coordinate releases between comparison code and core code
- Reduced noise in main repository commit history

## How the Repositories Work Together

### Coordinated Development

While separated, the repositories are designed to work together:

#### Common Benchmark Patterns

Both repositories follow similar patterns for comparable benchmarks:

**Main Repository** (`bigweaver-agent-canary-hydro-zeta`):
```rust
// benches/benches/identity.rs
fn benchmark_hydroflow(c: &mut Criterion) {
    // Hydroflow implementation
}

fn benchmark_hydroflow_surface(c: &mut Criterion) {
    // Hydroflow surface syntax
}

fn benchmark_hydroflow_compiled(c: &mut Criterion) {
    // Compiled Hydroflow
}
```

**This Repository** (`bigweaver-agent-canary-zeta-hydro-deps`):
```rust
// benches/benches/identity.rs
fn benchmark_timely(c: &mut Criterion) {
    // Timely Dataflow implementation
}
```

This parallel structure enables direct performance comparisons.

#### Shared Benchmark Parameters

Benchmarks use consistent parameters for fair comparison:

```rust
// Same constants in both repositories
const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;
```

#### Shared Test Data

Where applicable, benchmarks use identical test data:

- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected results
- `words_alpha.txt` - Word list for string operations

These files are duplicated in both repositories to ensure independence while maintaining comparability.

### Version Synchronization

The repositories are **loosely coupled**:

- **Main repository** evolves based on Hydroflow/DFIR development
- **This repository** evolves based on timely/differential releases
- No strict version coupling required
- Benchmarks remain comparable across versions

### Communication Between Repositories

#### Documentation Cross-References

Both repositories reference each other:

**In main repository**:
```markdown
## Performance Benchmarks

For performance comparisons with Timely and Differential-Dataflow, see the
[benchmark comparison repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps).
```

**In this repository** (current file):
```markdown
This repository provides benchmarks for comparison with the main
[bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta)
implementation.
```

#### Issue Tracking

Performance comparison issues are tracked in the relevant repository:

- **Hydroflow/DFIR performance issues** → Main repository
- **Timely/Differential benchmark issues** → This repository
- **Comparison methodology issues** → This repository

#### Pull Request Coordination

Sometimes changes need coordination:

**Scenario**: Adding a new benchmark pattern

**Process**:
1. Implement benchmark in main repository for Hydroflow/DFIR
2. If comparison is desired, create companion PR in this repository
3. Link PRs with comments referencing each other
4. Both can merge independently

**Example PR references**:
```markdown
Main repo PR: Companion PR in bigweaver-agent-canary-zeta-hydro-deps: #123
Deps repo PR: Implements comparison for main repo PR: hydro-project/bigweaver-agent-canary-hydro-zeta#456
```

## Independence vs. Coordination

### What's Independent

✅ **Build Systems**: Each repository has its own `Cargo.toml` and build configuration

✅ **Dependencies**: No shared dependencies beyond standard Rust ecosystem

✅ **Release Cycles**: Repositories can release on different schedules

✅ **CI/CD Pipelines**: Each has independent testing and validation

✅ **Versioning**: No requirement for synchronized version numbers

### What's Coordinated

🔗 **Benchmark Patterns**: Similar structure for comparable results

🔗 **Test Data**: Identical data files for fair comparison

🔗 **Documentation**: Cross-references and comparison guides

🔗 **Methodology**: Consistent approach to performance measurement

## Usage Patterns

### Pattern 1: Core Development (Main Repo Only)

Most developers working on Hydroflow/DFIR only need the main repository:

```bash
git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
cd bigweaver-agent-canary-hydro-zeta
cargo test
cargo bench -p benches
```

**When to use**: Regular development, testing, Hydroflow-focused work

### Pattern 2: Performance Comparison (Both Repos)

When comparing performance across frameworks:

```bash
# Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git

# Run benchmarks in both
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench --save-baseline timely

cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --save-baseline hydroflow

# Compare results
```

**When to use**: Performance analysis, optimization work, academic research

### Pattern 3: Benchmark Development (Focused)

When adding or modifying benchmarks:

```bash
# Work in the relevant repository
cd bigweaver-agent-canary-zeta-hydro-deps  # For timely/differential benchmarks
# OR
cd bigweaver-agent-canary-hydro-zeta      # For hydroflow benchmarks

# Develop and test
cargo bench --bench identity -- --quick
```

**When to use**: Adding new benchmarks, fixing benchmark bugs

## Migration History

### Original State

Initially, all benchmarks (Hydroflow, Timely, and Differential) were in the main repository:

```
bigweaver-agent-canary-hydro-zeta/
└── benches/
    ├── Cargo.toml (with timely & differential dependencies)
    └── benches/
        ├── identity.rs (all implementations)
        ├── reachability.rs (all implementations)
        └── ...
```

### Migration Process

The timely and differential benchmarks were extracted:

1. **Removed** from main repository:
   - Timely-specific code
   - Differential-specific code
   - Related dependencies

2. **Created** this repository with:
   - Extracted benchmark code
   - Minimal dependencies
   - Comprehensive documentation

3. **Updated** main repository with:
   - Documentation pointing to this repo
   - Migration notes
   - Performance comparison guide

### Current State

Two focused repositories with clear responsibilities:

**Main Repository**:
- Core Hydroflow/DFIR code
- Hydroflow benchmarks only
- Minimal dependencies

**This Repository**:
- Timely benchmarks
- Differential benchmarks
- Comparison tools and documentation

## Future Considerations

### Potential Evolution

The relationship between repositories may evolve:

#### Option 1: Status Quo (Recommended)

Maintain current separation for all the benefits outlined above.

#### Option 2: Monorepo with Workspaces

If coordination overhead becomes significant:
```
hydro-project-monorepo/
├── core/              # Main Hydroflow/DFIR
├── comparisons/       # This repo's content
└── Cargo.toml         # Workspace configuration
```

**Trade-offs**: Easier coordination but loses independence benefits

#### Option 3: Additional Comparison Repos

If more frameworks need comparison:
```
- bigweaver-agent-canary-zeta-hydro-deps (timely/differential)
- bigweaver-agent-canary-flink-deps (Apache Flink)
- bigweaver-agent-canary-spark-deps (Apache Spark)
```

**Trade-offs**: More repositories but maximum flexibility

## Best Practices

### For Main Repository Contributors

1. ✅ **Focus on Hydroflow/DFIR**: Don't worry about external frameworks
2. ✅ **Document benchmark patterns**: Help comparison repo stay synchronized
3. ✅ **Link to comparison repo**: In performance-related documentation
4. ⚠️ **Don't add timely/differential dependencies**: Keep separation clean

### For This Repository Contributors

1. ✅ **Mirror main repo patterns**: Use similar benchmark structure
2. ✅ **Keep dependencies minimal**: Only timely, differential, and essentials
3. ✅ **Document comparison methodology**: Explain how to interpret results
4. ⚠️ **Don't couple versions**: Remain independent of main repo versions

### For Performance Analysts

1. ✅ **Clone both repositories**: Need both for comprehensive analysis
2. ✅ **Use consistent methodology**: Follow guidelines in PERFORMANCE_COMPARISON.md
3. ✅ **Document environment**: Record system specs and conditions
4. ✅ **Save baselines**: Keep historical data for trend analysis

## Summary

**Key Takeaways**:

1. 🎯 **Clear Separation**: Main repo for core functionality, this repo for comparisons
2. 🔧 **Independence**: Each repository operates independently
3. 🔗 **Coordination**: Similar patterns enable fair performance comparison
4. 📊 **Flexibility**: Choose to use one or both repositories as needed
5. 🚀 **Benefits**: Faster builds, cleaner architecture, focused development

The separation creates a cleaner architecture while maintaining the ability to perform comprehensive performance comparisons when needed.

## Related Documentation

- **[README.md](README.md)** - Repository overview
- **[GETTING_STARTED.md](GETTING_STARTED.md)** - Setup and basic usage
- **[PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)** - Detailed comparison guide

## Questions?

For questions about:
- **Repository relationship**: Refer to this document
- **Performance comparison**: See PERFORMANCE_COMPARISON.md
- **Benchmark usage**: See GETTING_STARTED.md
- **Core Hydroflow/DFIR**: See main repository documentation
