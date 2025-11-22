# Relationship to Main Repository

This document explains how this repository (bigweaver-agent-canary-zeta-hydro-deps) relates to the main repository (bigweaver-agent-canary-hydro-zeta).

## Repository Separation Strategy

### Why Separate Repositories?

1. **Dependency Isolation**: Keep Timely and Differential Dataflow dependencies separate from the main Hydro codebase
2. **Clean Architecture**: Maintain a lean main repository focused on Hydro development
3. **Comparison Baseline**: Provide independent performance benchmarks for comparison
4. **Optional Integration**: Teams can choose whether to run comparison benchmarks

### What Each Repository Contains

#### Main Repository: bigweaver-agent-canary-hydro-zeta
- **Purpose**: Hydro project development and benchmarks
- **Contains**:
  - Hydro language implementations (dfir_rs, hydro_lang, etc.)
  - Hydro-specific benchmarks
  - Core application code
  - Deployment tools (hydro_deploy)
- **Dependencies**: Hydro-specific dependencies only

#### This Repository: bigweaver-agent-canary-zeta-hydro-deps
- **Purpose**: External framework benchmarks for comparison
- **Contains**:
  - Timely Dataflow benchmarks
  - Differential Dataflow benchmarks
  - Comparison documentation
- **Dependencies**: Timely, Differential Dataflow, and Criterion

## How to Use Both Repositories

### Scenario 1: Just Developing Hydro

If you're only working on Hydro development:

```bash
# You only need the main repository
cd bigweaver-agent-canary-hydro-zeta
cargo build
cargo test
cargo bench  # Run Hydro benchmarks
```

You don't need this repository at all!

### Scenario 2: Comparing Performance

If you want to compare Hydro's performance with established frameworks:

```bash
# Step 1: Run benchmarks in deps repository
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline timely-differential

# Step 2: Run benchmarks in main repository
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -- --save-baseline hydro

# Step 3: Compare results
# See BENCHMARK_COMPARISON.md for detailed comparison procedures
```

### Scenario 3: Performance Research

If you're researching dataflow framework performance:

```bash
# Clone both repositories side-by-side
mkdir hydro-project
cd hydro-project
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Run comprehensive benchmarks
cd bigweaver-agent-canary-zeta-hydro-deps
./run_all_benchmarks.sh research-baseline

cd ../bigweaver-agent-canary-hydro-zeta
# Run equivalent Hydro benchmarks

# Analyze and document findings
```

## Benchmark Correspondence

### Similar Benchmarks Across Repositories

| Concept | This Repo (Timely/Differential) | Main Repo (Hydro) |
|---------|--------------------------------|-------------------|
| Basic Operations | `arithmetic.rs`, `identity.rs` | Look in `dfir_rs` benchmarks |
| Stream Patterns | `fan_in.rs`, `fan_out.rs` | Check dataflow examples |
| Filtering/Mapping | `micro_ops.rs` | Operator benchmarks |
| Graph Algorithms | `reachability.rs` | Graph processing examples |

### Benchmark Mapping Guide

When comparing specific patterns:

1. **Find equivalent functionality** in both repositories
2. **Match input sizes** for fair comparison
3. **Use same measurement methodology** (Criterion.rs in both)
4. **Account for programming model differences** (see below)

## Programming Model Differences

Understanding these differences is crucial for fair comparison:

### Timely/Differential (This Repo)
- **Model**: Low-level imperative dataflow
- **API**: Direct operator chaining
- **Optimization**: Runtime operator fusion
- **Example**:
  ```rust
  stream.map(|x| x * 2)
        .filter(|x| x > 10)
        .inspect(|x| println!("{}", x));
  ```

### Hydro (Main Repo)
- **Model**: High-level declarative with staging
- **API**: Staged Rust with location types
- **Optimization**: Compile-time via macro expansion
- **Example**:
  ```rust
  // Hydro uses staged programming
  // See main repo for actual examples
  ```

### What This Means for Comparisons

- **Direct code comparison isn't meaningful**: Different programming models
- **Performance comparison is meaningful**: Both solve similar problems
- **Overhead comparison is valid**: Framework costs can be measured
- **Optimization strategies differ**: Compile-time vs runtime

## Dependency Management

### No Cross-Repository Dependencies

These repositories are intentionally decoupled:

```
bigweaver-agent-canary-hydro-zeta  (No dependency on deps repo)
    ↓
   Uses only Hydro dependencies

bigweaver-agent-canary-zeta-hydro-deps  (No dependency on main repo)
    ↓
   Uses only Timely/Differential dependencies
```

This clean separation means:
- ✅ Each repository can be built independently
- ✅ No version conflicts
- ✅ Clear dependency boundaries
- ✅ Optional comparison capability

### If You Need Both

Use a workspace at a higher level:

```toml
# Optional: Create a super-workspace
[workspace]
members = [
    "bigweaver-agent-canary-hydro-zeta",
    "bigweaver-agent-canary-zeta-hydro-deps",
]
```

But this is **not required** and may not be desirable for most use cases.

## Workflow Integration

### Development Workflow

```
Daily Development
    ↓
Main Repository Only
    ↓
Code → Test → Commit
```

No need to touch the deps repository during regular development.

### Performance Testing Workflow

```
Before Release
    ↓
Run Main Repo Benchmarks
    ↓
Run Deps Repo Benchmarks
    ↓
Compare Results
    ↓
Document Findings
    ↓
Validate Release
```

### Research Workflow

```
Performance Research
    ↓
Design Comparable Benchmarks
    ↓
Implement in Both Repos
    ↓
Run Comprehensive Suite
    ↓
Statistical Analysis
    ↓
Publish Findings
```

## Version Compatibility

### Framework Versions

This repository uses:
- Timely Dataflow: v0.12
- Differential Dataflow: v0.12

Update when:
- New major versions are released
- Performance characteristics change significantly
- Bug fixes affect benchmark results

### Synchronization

The repositories don't need to be in sync:
- Main repo can evolve independently
- Deps repo provides stable baseline
- Update deps repo when frameworks update

## Contributing Guidelines

### Contributing to Main Repository

See main repository's CONTRIBUTING.md

### Contributing to This Repository

When contributing benchmarks:

1. **Ensure independence**: Don't depend on main repository
2. **Follow naming conventions**: Match pattern names across frameworks
3. **Document purpose**: Explain what the benchmark measures
4. **Add to comparison guide**: Update BENCHMARK_COMPARISON.md
5. **Test thoroughly**: Verify benchmarks run correctly

### Adding Equivalent Benchmarks

If you add a benchmark pattern to one repository:

1. Consider whether it should exist in both
2. Implement similar (not identical) versions
3. Document the relationship
4. Update comparison guides

## Communication Between Teams

### Main Repository Team

Focus on:
- Hydro development and optimization
- Core functionality
- Language features
- Distributed execution

### Deps Repository Team (Benchmarking)

Focus on:
- Maintaining comparison baselines
- Updating external framework versions
- Documenting performance characteristics
- Providing comparison data

### Coordination Points

Teams coordinate when:
- New benchmark patterns are needed
- Performance questions arise
- Release validation is required
- Research papers are written

## Documentation Cross-References

### From Main Repo to This Repo

Main repository might reference:
- Performance comparison data
- Baseline benchmark results
- External framework examples

### From This Repo to Main Repo

This repository references:
- Main repository structure (for context)
- Equivalent Hydro benchmarks (for comparison)
- Hydro documentation (for understanding)

## Future Evolution

### Potential Integration Points

As both repositories evolve:

1. **Automated comparison**: CI/CD pipeline comparing both
2. **Shared test data**: Common datasets for benchmarks
3. **Unified reporting**: Combined performance dashboards
4. **Cross-validation**: Correctness checking across frameworks

### Maintaining Separation

Even with integration, maintain:
- Independent build systems
- Separate dependency trees
- Clear boundaries
- Optional relationship

## Quick Reference

### When to Use Main Repo Only
- ✅ Regular Hydro development
- ✅ Feature implementation
- ✅ Bug fixes
- ✅ Unit testing

### When to Use Deps Repo
- ✅ Performance comparison
- ✅ Baseline establishment
- ✅ External framework research
- ✅ Academic benchmarking

### When to Use Both
- ✅ Release validation
- ✅ Performance research
- ✅ Optimization validation
- ✅ Publication preparation

## Getting Help

### For Main Repository Issues
Consult main repository documentation and team

### For Deps Repository Issues
Refer to:
- [README.md](./README.md) - General documentation
- [QUICKSTART.md](./QUICKSTART.md) - Getting started
- [TESTING.md](./TESTING.md) - Verification procedures

### For Comparison Questions
See [BENCHMARK_COMPARISON.md](./BENCHMARK_COMPARISON.md)

## Summary

This repository exists to:
1. **Provide independent benchmarks** of established frameworks
2. **Enable performance comparison** with Hydro
3. **Maintain clean separation** of dependencies
4. **Support research and validation** efforts

It is **optional** and **complementary** to the main repository, not a requirement for Hydro development.
