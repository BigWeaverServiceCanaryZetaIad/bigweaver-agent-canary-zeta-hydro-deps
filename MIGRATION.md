# Benchmark Repository Migration Guide

This document explains why benchmarks are maintained in a separate repository and how to work with the split structure.

## Why Separate Repository?

### Rationale

The benchmark suite has been separated into the `bigweaver-agent-canary-zeta-hydro-deps` repository for several important reasons:

1. **Dependency Isolation**
   - Timely and Differential Dataflow are large dependencies
   - Main Hydro repository stays lean without these dev-only dependencies
   - Reduces build times for normal development

2. **Cleaner Dependency Graph**
   - Avoids circular dependencies
   - Main repo doesn't need to depend on competing frameworks
   - Clearer separation between production and benchmark code

3. **Independent Development**
   - Benchmarks can be updated without touching main codebase
   - Benchmark improvements don't trigger main repo rebuilds
   - Different release cycles for benchmarks vs main code

4. **Build Performance**
   - Main repo builds faster without benchmark dependencies
   - CI/CD pipelines more efficient
   - Developer experience improved

### Team Practice

This separation follows the team's established practice of:
> "Moving benchmarks and dependencies into dedicated repositories to avoid having certain dependencies in the main repository while still retaining necessary functionality."

This pattern is consistently applied across the project for technical debt prevention and maintainability.

## Repository Structure

### bigweaver-agent-canary-hydro-zeta (Main Repository)

```
bigweaver-agent-canary-hydro-zeta/
├── dfir_rs/              # Core Hydro dataflow implementation
├── dfir_lang/            # Language constructs
├── hydro_deploy/         # Deployment tools
├── hydro_lang/           # High-level language
├── sinktools/            # Sink utilities
└── ...                   # Other core components
```

**Purpose**: Production code, core functionality, public API

**Dependencies**: Minimal, production-focused

### bigweaver-agent-canary-zeta-hydro-deps (Benchmark Repository)

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/          # Benchmark source files
│   ├── Cargo.toml        # Benchmark dependencies
│   └── README.md         # Benchmark documentation
├── README.md             # Repository overview
├── PERFORMANCE_COMPARISON.md  # Performance guide
├── QUICK_REFERENCE.md    # Quick reference
└── run_benchmarks.sh     # Helper script
```

**Purpose**: Performance testing, framework comparison, regression detection

**Dependencies**: Includes timely, differential-dataflow, and other benchmark-specific deps

## Working with Both Repositories

### Directory Layout

The repositories should be checked out side-by-side:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main repo
└── bigweaver-agent-canary-zeta-hydro-deps/ # Benchmark repo
```

This layout allows the benchmark repository to reference the main repository via relative paths:

```toml
# In benches/Cargo.toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

### Development Workflow

#### 1. Working on Main Repository

When developing Hydro features:

```bash
cd bigweaver-agent-canary-hydro-zeta

# Make changes to dfir_rs, hydro_lang, etc.
vim dfir_rs/src/my_feature.rs

# Run main repo tests
cargo test

# Build and verify
cargo build
```

#### 2. Running Benchmarks

After making changes to the main repository:

```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps

# Run benchmarks to check performance impact
cargo bench -p benches

# Or use helper script
./run_benchmarks.sh --quick
```

#### 3. Performance Validation Workflow

Complete workflow for performance-sensitive changes:

```bash
# 1. Establish baseline in benchmark repo
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches -- --save-baseline before-changes

# 2. Make changes in main repo
cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...
cargo test  # Verify correctness

# 3. Run benchmarks and compare
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches -- --baseline before-changes

# 4. Review performance impact
open target/criterion/report/index.html
```

## Coordinated Changes

### When Both Repositories Need Updates

Some changes require coordinated updates across both repositories:

#### Scenario 1: API Changes in Main Repo

If you change the public API in `dfir_rs`:

1. **Update main repository**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Make API changes
   git commit -m "feat(dfir_rs): new API for X"
   ```

2. **Update benchmarks**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   # Update benchmark code to use new API
   vim benches/benches/my_benchmark.rs
   cargo bench -p benches  # Verify it compiles and runs
   git commit -m "feat(benches): update for new dfir_rs API"
   ```

3. **Create companion PRs**:
   - Create PR for main repo
   - Create companion PR for benchmark repo
   - Cross-reference in PR descriptions
   - Note merge order if needed

#### Scenario 2: New Feature with Benchmark

When adding a new feature that needs benchmarking:

1. **Implement feature in main repo**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   # Implement feature
   cargo test
   ```

2. **Add benchmark in benchmark repo**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   # Create new benchmark file
   vim benches/benches/new_feature.rs
   
   # Add to Cargo.toml
   echo '[[bench]]\nname = "new_feature"\nharness = false' >> benches/Cargo.toml
   
   # Test benchmark
   cargo bench -p benches --bench new_feature
   ```

3. **Document and commit**:
   ```bash
   # Update documentation
   vim benches/README.md  # Add description of new benchmark
   
   git commit -m "feat(benches): add benchmark for new_feature"
   ```

### PR Coordination

When changes span both repositories, use this PR structure:

**Main Repository PR**:
```markdown
## Overview
Implements new feature X in dfir_rs

## Related PRs
- Companion benchmark PR: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps#123

## Testing
- Unit tests pass
- Integration tests pass
- Benchmarks available in companion PR
```

**Benchmark Repository PR**:
```markdown
## Overview
Adds benchmark for feature X from main repository

## Related PRs
- Main feature PR: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta#456
- **Merge Order**: MERGE SECOND (after main PR)

## Performance Results
[Include benchmark results comparing before/after]
```

## Troubleshooting

### Problem: Can't find dfir_rs

```
error: failed to load manifest for dependency `dfir_rs`
Caused by:
  failed to read `/path/to/bigweaver-agent-canary-hydro-zeta/dfir_rs/Cargo.toml`
```

**Solution**: Verify directory structure
```bash
# Should show both repos side-by-side
ls ..
# bigweaver-agent-canary-hydro-zeta  bigweaver-agent-canary-zeta-hydro-deps

# If not, adjust paths in benches/Cargo.toml
```

### Problem: Benchmark builds but uses old version

**Solution**: Clean and rebuild
```bash
cargo clean -p benches
cargo bench -p benches
```

### Problem: Benchmarks fail after main repo changes

**Likely Cause**: API incompatibility

**Solution**: Update benchmark code to match new API
```bash
# Check what changed in main repo
cd ../bigweaver-agent-canary-hydro-zeta
git log --oneline dfir_rs/

# Update benchmark code accordingly
cd ../bigweaver-agent-canary-zeta-hydro-deps
vim benches/benches/affected_benchmark.rs
```

## Best Practices

### 1. Keep Repositories in Sync

- When changing main repo APIs, update benchmarks promptly
- Test benchmarks after significant main repo changes
- Create companion PRs for related changes

### 2. Maintain Clean Separation

- Don't add benchmark code to main repository
- Don't add production code to benchmark repository
- Keep dependencies separate

### 3. Document Cross-Repository Changes

- Link related PRs in descriptions
- Note merge order when required
- Document breaking changes that affect benchmarks

### 4. Regular Performance Checks

- Run benchmarks periodically on main branch
- Track performance trends over time
- Catch regressions early

### 5. Baseline Management

- Save baselines for major releases
- Compare against previous versions
- Document performance improvements/regressions

## Migration Checklist

If you previously had benchmarks in the main repository, here's how to migrate:

- [ ] Clone benchmark repository alongside main repository
- [ ] Verify path structure matches expected layout
- [ ] Run `cargo bench -p benches` to verify setup
- [ ] Save initial baseline: `cargo bench -p benches -- --save-baseline main`
- [ ] Update CI/CD pipelines to include benchmark runs (optional)
- [ ] Remove old benchmark references from main repository (if any)
- [ ] Update team documentation with new workflow

## FAQ

**Q: Why can't we just keep benchmarks in the main repo?**

A: Separating benchmarks reduces build times, keeps dependencies clean, and follows team best practices for managing technical debt.

**Q: Do I need to clone both repos?**

A: Yes, if you want to run benchmarks. The benchmark repo references the main repo via relative paths.

**Q: What if the paths don't match?**

A: Adjust the relative paths in `benches/Cargo.toml` to match your directory structure.

**Q: How often should I run benchmarks?**

A: Run quick benchmarks during development, full benchmarks before submitting PRs, and comprehensive benchmarks before releases.

**Q: Can I run benchmarks in CI?**

A: Yes! See the CI/CD integration examples in QUICK_REFERENCE.md.

**Q: What if benchmarks fail?**

A: First check if it's an API compatibility issue. Update benchmark code to match main repo changes, then re-run.

**Q: How do I add a new benchmark?**

A: Create a new `.rs` file in `benches/benches/`, add a `[[bench]]` entry to `Cargo.toml`, and update documentation. See QUICK_REFERENCE.md for details.

## Additional Resources

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Benchmark Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)
- [README.md](README.md) - Repository overview
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Common commands
- [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) - Detailed performance guide
- [benches/README.md](benches/README.md) - Detailed benchmark descriptions
