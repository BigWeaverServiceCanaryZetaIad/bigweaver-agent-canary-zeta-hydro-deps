# Benchmark Refactoring Required

## Summary

The timely/differential-dataflow benchmark migration from `bigweaver-agent-canary-hydro-zeta` to `bigweaver-agent-canary-zeta-hydro-deps` is complete at a structural level, but the benchmark files need refactoring to remove dependencies on packages that no longer exist (babyflow, hydroflow, spinachflow).

## Current State

✅ **Completed:**
- Main repository cleaned (only README.md remains)
- Benchmarks moved to deps repository
- Cargo.toml updated to remove unused dependencies (differential-dataflow, rand, seq-macro, tokio)
- Removed zip benchmark from Cargo.toml (no timely implementation exists)
- identity.rs refactored to contain only timely benchmark
- Documentation created (README.md, MIGRATION.md)
- Comparison script created

❌ **Remaining Work:**
- 7 benchmark files still reference missing dependencies and won't compile
- Need to extract only the timely portions from each file

## Files That Need Refactoring

1. **arithmetic.rs** - Has babyflow, hydroflow, spinachflow code - extract benchmark_timely only
2. **fan_in.rs** - Has babyflow, hydroflow, spinachflow code - extract benchmark_timely only
3. **fan_out.rs** - Has babyflow, hydroflow code - extract benchmark_timely only
4. **fork_join.rs** - Has babyflow, hydroflow, spinachflow code - extract benchmark_timely only
5. **identity.rs** - ✅ DONE (clean, timely-only)
6. **join.rs** - Has babyflow, hydroflow code - extract benchmark_timely only (preserve generic structure)
7. **reachability.rs** - Has babyflow code - extract benchmark_timely only (keep lazy_static data loading)
8. **upcase.rs** - Has babyflow, hydroflow code - extract benchmark_timely only (keep Operation trait)
9. **zip.rs** - Removed from Cargo.toml (no timely implementation)

## Why This Is Needed

The original benchmarks were **comparison benchmarks** that tested multiple dataflow framework implementations side-by-side:
- timely-dataflow (external crate)
- babyflow (was in main repo, now deleted)
- hydroflow (was in main repo, now deleted)
- spinachflow (was in main repo, now deleted)

When these benchmarks were migrated, the goal was to separate timely/differential dependencies from the main codebase. However, the benchmark code still references the other frameworks, causing compilation failures.

## Solution: Extract Timely-Only Code

Each benchmark file should be refactored to this pattern:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{/* only what's needed */};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

// Helper functions if needed

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("benchmark_name/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                // Timely dataflow implementation
            });
        })
    });
}

criterion_group!(benchmark_name_dataflow, benchmark_timely);
criterion_main!(benchmark_name_dataflow);
```

## Special Cases

### join.rs
- Preserve generic structure for testing different value types
- Remove non-timely benchmark functions
- Keep: `JoinValue` trait, implementations, and `benchmark_timely<L, R>` function

### reachability.rs
- Keep `lazy_static!` blocks for loading data files
- Keep data files: `reachability_edges.txt`, `reachability_reachable.txt`
- Extract only `benchmark_timely` function

### upcase.rs
- Keep `Operation` trait and `UpcaseInPlace` implementation
- Extract only `benchmark_timely` function

## Clean Examples Available

Template files showing the correct refactored structure are available at `/tmp/`:
- `arithmetic.rs` - Clean, timely-only version
- `fan_in.rs` - Clean, timely-only version (includes `make_ints` helper)
- `fan_out.rs` - Clean, timely-only version
- `fork_join.rs` - Clean, timely-only version (includes constants)

## Current Cargo.toml

Already updated to include only necessary dependencies:

```toml
[dev-dependencies]
criterion = { version = "0.3", features = ["async_tokio"] }
timely = "0.12"
lazy_static = "1.4.0"  # For reachability benchmark data loading
```

## Verification Steps

After completing the refactoring:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Check syntax and dependencies
cargo check --all

# Run tests (if any)
cargo test

# Run benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

## Estimated Effort

- **Time**: 2-4 hours
- **Complexity**: Low-Medium (mostly copy-paste work, special attention needed for join.rs, reachability.rs, upcase.rs)
- **Risk**: Low (original code preserved in git history)

## Documentation Updates Needed After Refactoring

1. Update `README.md` to clarify these are pure timely-dataflow benchmarks
2. Update `MIGRATION.md` with final status
3. Update `scripts/compare_benchmarks.sh` to reflect the change
4. Consider adding note about why comparison benchmarks were removed
