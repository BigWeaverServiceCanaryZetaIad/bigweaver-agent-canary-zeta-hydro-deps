# Compatibility Guide

This document describes how to maintain compatibility between the bigweaver-agent-canary-zeta-hydro-deps repository and the main bigweaver-agent-canary-hydro-zeta repository.

## Repository Relationship

The benchmarks in this repository depend on the DFIR implementation from the main repository via a path dependency in `benches/Cargo.toml`:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

This means:
1. Both repositories should be cloned as siblings in the same parent directory
2. Changes to the main repository's API may require updates to the benchmarks here
3. The benchmarks always use the local version of DFIR from the main repository

## Expected Directory Structure

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/      # Main repository
  │   ├── dfir_rs/                            # DFIR implementation
  │   └── ...
  └── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
      └── benches/
          ├── benches/                        # Benchmark implementations
          └── Cargo.toml                      # References ../../../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

## Updating Benchmarks When Main Repository Changes

### API Changes in DFIR

When the main repository changes DFIR APIs that are used in benchmarks:

1. Update the benchmark code in `benches/benches/*.rs` to use the new APIs
2. Test that benchmarks compile and run:
   ```bash
   cd benches
   cargo check
   cargo bench
   ```
3. Document any performance impact from the API changes

### Module/Package Renames

If packages in the main repository are renamed:

1. Update the dependency in `benches/Cargo.toml`
2. Update import statements in `benches/benches/*.rs`
3. Verify all benchmarks still compile

### Adding New Features

When adding new DFIR features that should be benchmarked:

1. Create a new benchmark file in `benches/benches/your_feature.rs`
2. Implement comparisons with timely/differential-dataflow where applicable
3. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "your_feature"
   harness = false
   ```
4. Update `benches/README.md` to document the new benchmark
5. Add baseline performance expectations if known

## Version Compatibility

### Main Repository Versions

The benchmarks track the `main` branch of the main repository. When the main repository:
- **Releases a new version**: Consider tagging this repository with a corresponding version
- **Makes breaking changes**: Update benchmarks promptly to maintain compatibility
- **Adds new features**: Evaluate if comparative benchmarks would be valuable

### External Dependencies

The benchmarks depend on specific versions of timely and differential-dataflow:

```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

When updating these:
1. Update both version numbers together
2. Verify all benchmarks still compile
3. Run benchmarks to establish new baseline performance
4. Document any performance changes in a benchmark results file

## Testing Strategy

### Before Committing Changes

1. Verify the main repository compiles:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo check --all-targets
   ```

2. Verify benchmarks compile:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo check
   ```

3. Run at least one benchmark to verify runtime compatibility:
   ```bash
   cargo bench --bench identity
   ```

### Continuous Integration

If CI is configured:
- Run benchmarks on changes to this repository
- Consider running benchmarks when the main repository is updated
- Store benchmark results to track performance over time

## Common Issues

### Path Dependency Not Found

**Symptom**: `error: failed to read ... No such file or directory`

**Solution**: Ensure both repositories are cloned as siblings:
```bash
cd /projects
ls -d bigweaver-agent-canary-hydro-zeta bigweaver-agent-canary-zeta-hydro-deps
```

### Compilation Errors After Main Repository Update

**Symptom**: Benchmarks fail to compile after pulling latest from main repository

**Solution**: 
1. Check the main repository's changelog for API changes
2. Update benchmark code to match new APIs
3. If unsure, reference similar usage in the main repository's tests

### Version Mismatches

**Symptom**: `the trait ... is not implemented for ...`

**Solution**:
1. Ensure Cargo.lock is up to date: `cargo update`
2. Verify workspace dependencies in both repositories match where applicable
3. Check that feature flags are consistent

## Communication

When making changes that affect compatibility:

1. **In the main repository**: If changing APIs used by benchmarks, consider:
   - Mentioning it in the PR description
   - Checking if benchmarks need updates
   - Coordinating with the benchmarks maintainer

2. **In this repository**: If benchmarks break due to main repository changes:
   - Document the breaking change
   - Update benchmarks promptly
   - Consider whether the change affects performance

## Future Improvements

Potential improvements to the compatibility story:

- **Version pinning**: Pin to specific git commits or tags of the main repository
- **Automated testing**: Set up CI to test against main repository changes
- **Performance tracking**: Maintain historical benchmark results
- **Documentation generation**: Auto-generate compatibility notes from changelogs
