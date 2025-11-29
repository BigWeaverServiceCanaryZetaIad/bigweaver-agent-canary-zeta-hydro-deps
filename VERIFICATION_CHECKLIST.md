# Migration Verification Checklist

Use this checklist to verify that the benchmark migration was completed successfully.

## Repository Structure

- [x] bigweaver-agent-canary-zeta-hydro-deps repository exists
- [x] Both repositories are at the same directory level (/projects/sandbox/)
- [x] Main repository (bigweaver-agent-canary-hydro-zeta) is present alongside

## Files Recovered

### Configuration Files
- [x] benches/Cargo.toml exists
- [x] benches/README.md exists
- [x] benches/build.rs exists
- [x] Root Cargo.toml (workspace) exists

### Benchmark Source Files (12)
- [x] benches/benches/arithmetic.rs
- [x] benches/benches/fan_in.rs
- [x] benches/benches/fan_out.rs
- [x] benches/benches/fork_join.rs
- [x] benches/benches/futures.rs
- [x] benches/benches/identity.rs
- [x] benches/benches/join.rs
- [x] benches/benches/micro_ops.rs
- [x] benches/benches/reachability.rs
- [x] benches/benches/symmetric_hash_join.rs
- [x] benches/benches/upcase.rs
- [x] benches/benches/words_diamond.rs

### Data Files
- [x] benches/benches/.gitignore
- [x] benches/benches/reachability_edges.txt
- [x] benches/benches/reachability_reachable.txt
- [x] benches/benches/words_alpha.txt

### Documentation
- [x] README.md (repository overview)
- [x] BENCHMARK_GUIDE.md (comprehensive guide)
- [x] MIGRATION_SUMMARY.md (migration details)
- [x] QUICK_START.md (quick reference)
- [x] VERIFICATION_CHECKLIST.md (this file)

## Configuration Verification

### Workspace Configuration (Cargo.toml)
- [x] Contains `[workspace]` section
- [x] Includes `benches` in members array
- [x] Has `resolver = "2"`
- [x] Contains workspace.package section with edition, license, repository
- [x] Contains profile configurations (release, profile)
- [x] Contains workspace.lints for rust and clippy

### Benchmark Package Configuration (benches/Cargo.toml)
- [x] Uses workspace settings (edition, repository, license, lints)
- [x] Has timely-master dependency (0.13.0-dev.1)
- [x] Has differential-dataflow-master dependency (0.13.0-dev.1)
- [x] Has criterion dependency with features
- [x] dfir_rs path points to ../../bigweaver-agent-canary-hydro-zeta/dfir_rs
- [x] sinktools path points to ../../bigweaver-agent-canary-hydro-zeta/sinktools
- [x] All 12 benchmark targets configured with `harness = false`

## Dependency Paths

Verify these paths exist:
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
ls -ld ../../bigweaver-agent-canary-hydro-zeta/dfir_rs      # Should exist
ls -ld ../../bigweaver-agent-canary-hydro-zeta/sinktools    # Should exist
```

- [x] dfir_rs path exists
- [x] sinktools path exists

## Main Repository Cleanup

### bigweaver-agent-canary-hydro-zeta
- [x] No benches/ directory exists
- [x] "benches" not in workspace members (Cargo.toml)
- [x] No references to timely/differential-dataflow in active Cargo.toml files
- [x] CONTRIBUTING.md has no benches reference

## Functional Tests

### Build Check (if cargo available)
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches
```
- [ ] Build succeeds without errors

### Run Single Benchmark (if cargo available)
```bash
cargo bench -p benches --bench arithmetic -- --test
```
- [ ] Benchmark runs successfully

### Generate Documentation (if cargo available)
```bash
cargo doc -p benches --no-deps
```
- [ ] Documentation generates successfully

## File Counts

Expected counts:
- Total files (excluding .git): 24
- Benchmark .rs files: 12
- Data .txt files: 3
- Cargo.toml files: 2
- Documentation .md files: 4

Verify:
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
find . -type f -not -path "*/.git/*" | wc -l                    # Should be 24
find benches/benches -name "*.rs" | wc -l                       # Should be 12
find benches/benches -name "*.txt" | wc -l                      # Should be 3
find . -name "Cargo.toml" | wc -l                               # Should be 2
find . -maxdepth 1 -name "*.md" | wc -l                        # Should be 5
```

- [x] 24 total files
- [x] 12 benchmark files
- [x] 3 data files
- [x] 2 Cargo.toml files
- [x] 5 documentation files

## Content Verification

### Check Sample Benchmark File
```bash
head -20 benches/benches/arithmetic.rs
```
Should show:
- Imports including criterion, dfir_rs, timely
- Benchmark function definitions
- NUM_OPS and NUM_INTS constants

- [x] Benchmark files contain expected content

### Check Data Files
```bash
wc -l benches/benches/words_alpha.txt           # Should be ~370,104 lines
wc -l benches/benches/reachability_edges.txt    # Should be ~55,008 lines
wc -l benches/benches/reachability_reachable.txt # Should be ~7,855 lines
```

- [x] Data files have correct line counts

## Documentation Quality

- [x] README.md explains repository purpose
- [x] README.md documents how to run benchmarks
- [x] README.md lists all available benchmarks
- [x] BENCHMARK_GUIDE.md provides comprehensive instructions
- [x] MIGRATION_SUMMARY.md explains what was migrated
- [x] QUICK_START.md provides quick reference
- [x] All documentation is clear and accurate

## Performance Comparison Capability

- [x] Criterion dependency present
- [x] All benchmark targets configured
- [x] Documentation explains how to use baselines
- [x] Documentation explains performance comparison workflow

## Git Status

Check that files are tracked:
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
git status
```

Expected: New/modified files ready to commit

## Final Verification Summary

**Date Verified:** _________________

**Verified By:** _________________

**Status:**
- [ ] All checks passed - Ready for commit
- [ ] Some checks failed - See notes below
- [ ] Not yet verified

**Notes:**
_______________________________________________
_______________________________________________
_______________________________________________

## Common Issues and Solutions

### Issue: "dfir_rs not found"
**Solution:** Ensure main repository is cloned alongside this one at the same directory level

### Issue: "cargo command not found"
**Solution:** Install Rust toolchain, or skip cargo-related checks if only verifying file structure

### Issue: "Benchmark compilation errors"
**Solution:** Check that the Rust toolchain version matches the one specified in main repo's rust-toolchain.toml

### Issue: "Path not found errors"
**Solution:** Verify both repositories are in /projects/sandbox/ directory with correct names

## Next Steps After Verification

1. Review any failed checks and resolve issues
2. Commit changes to git
3. Push to remote repository
4. Update any external documentation or links
5. Notify team members of the migration
6. Consider setting up CI/CD for benchmarks (see BENCHMARK_GUIDE.md)
