# Repository Manifest

Complete list of all files added to the bigweaver-agent-canary-zeta-hydro-deps repository.

## Benchmark Files (8 files, 47 KB)

1. `benches/arithmetic.rs` (7.5 KB)
   - Arithmetic operations benchmark comparing pipeline, raw, timely, and DFIR implementations

2. `benches/fan_in.rs` (3.4 KB)
   - Fan-in pattern benchmark (multiple inputs → single output)

3. `benches/fan_out.rs` (3.5 KB)
   - Fan-out pattern benchmark (single input → multiple outputs)

4. `benches/fork_join.rs` (4.2 KB)
   - Fork-join pattern benchmark with output verification

5. `benches/identity.rs` (6.7 KB)
   - Minimal overhead benchmark for framework baseline measurement

6. `benches/join.rs` (4.4 KB)
   - Stream join operations benchmark

7. `benches/upcase.rs` (3.1 KB)
   - String transformation benchmark

8. `benches/reachability.rs` (13 KB)
   - Graph reachability computation using differential dataflow

## Test Data Files (2 files, 559 KB)

9. `benches/reachability_edges.txt` (520 KB)
   - Graph edges data for reachability benchmark

10. `benches/reachability_reachable.txt` (38 KB)
    - Expected reachable nodes for verification

## Configuration Files (4 files, 2 KB)

11. `Cargo.toml` (1.3 KB)
    - Package configuration with all dependencies and benchmark declarations

12. `rust-toolchain.toml` (159 B)
    - Rust version 1.91.1 with required components

13. `.gitignore` (152 B)
    - Git ignore rules for Rust projects and benchmark outputs

14. `benches/.gitignore` (15 B)
    - Ignore fork_join output files

## Documentation (7 files, 68 KB)

15. `README.md` (7.0 KB)
    - Main repository overview, benchmark descriptions, and usage guide

16. `BENCHMARKS.md` (11 KB)
    - Detailed benchmark documentation with interpretation guide

17. `QUICKSTART.md` (5.9 KB)
    - Quick start tutorial for new users

18. `CONTRIBUTING.md` (8.8 KB)
    - Guidelines for adding benchmarks and contributing

19. `SETUP_SUMMARY.md` (13 KB)
    - Complete setup documentation and technical details

20. `COMPLETION_REPORT.md` (13 KB)
    - Task completion report with requirements status

21. `FILES_OVERVIEW.txt` (8.8 KB)
    - Visual overview of repository structure and contents

## Scripts (2 files, 8 KB)

22. `verify_benchmarks.sh` (3.7 KB)
    - Automated verification script with comprehensive checks

23. `run_comparison.sh` (4.4 KB)
    - Helper script for running benchmark comparisons

## Source Code (1 file, 122 B)

24. `src/lib.rs` (122 B)
    - Minimal library file (benchmarks-only repository)

## Legal (1 file, 11 KB)

25. `LICENSE` (11 KB)
    - Apache-2.0 license (copied from main repository)

## Summary

- **Total Files**: 25
- **Total Size**: ~695 KB
- **Benchmark Code**: 47 KB (8 files)
- **Test Data**: 559 KB (2 files)
- **Documentation**: 68 KB (7 files)
- **Configuration**: 2 KB (4 files)
- **Scripts**: 8 KB (2 files)
- **Source**: 122 B (1 file)
- **License**: 11 KB (1 file)

## Dependencies Added

### Core Frameworks
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `dfir_rs` (from main repository via git)
- `sinktools` (from main repository via git)

### Benchmark Framework
- `criterion` 0.5.0 (with async_tokio and html_reports features)

### Supporting Libraries
- `futures` 0.3
- `tokio` 1.29.0 (with rt-multi-thread feature)
- `rand` 0.8.0
- `rand_distr` 0.4.3
- `nameof` 1.0.0
- `seq-macro` 0.2.0
- `static_assertions` 1.0.0

## Benchmarks Configured

All 8 benchmarks are declared in Cargo.toml with `harness = false`:

1. arithmetic
2. fan_in
3. fan_out
4. fork_join
5. identity
6. join
7. reachability
8. upcase

## Verification Status

✅ All files created successfully  
✅ All dependencies configured  
✅ All benchmarks declared  
✅ Verification script passes  
✅ Repository structure complete  

Run `./verify_benchmarks.sh` to verify the setup.
