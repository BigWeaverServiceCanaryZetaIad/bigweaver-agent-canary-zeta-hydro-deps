# Updates Required for Original Repository

This document describes the changes that should be made to the `bigweaver-agent-canary-hydro-zeta` repository after migrating the timely and differential-dataflow benchmarks.

## Repository: bigweaver-agent-canary-hydro-zeta

### Files to Remove

Remove the following files from `benches/benches/`:
- `arithmetic.rs`
- `fan_in.rs`
- `fan_out.rs`
- `fork_join.rs`
- `identity.rs`
- `join.rs`
- `upcase.rs`
- `reachability.rs`
- `reachability_edges.txt`
- `reachability_reachable.txt`

**Command:**
```bash
cd bigweaver-agent-canary-hydro-zeta/benches/benches
rm -f arithmetic.rs fan_in.rs fan_out.rs fork_join.rs identity.rs join.rs upcase.rs reachability.rs reachability_edges.txt reachability_reachable.txt
```

### Update benches/Cargo.toml

Remove the following `[[bench]]` entries from `benches/Cargo.toml`:

```toml
# REMOVE THESE ENTRIES:

[[bench]]
name = "arithmetic"
harness = false

[[bench]]
name = "fan_in"
harness = false

[[bench]]
name = "fan_out"
harness = false

[[bench]]
name = "fork_join"
harness = false

[[bench]]
name = "identity"
harness = false

[[bench]]
name = "upcase"
harness = false

[[bench]]
name = "join"
harness = false

[[bench]]
name = "reachability"
harness = false
```

**Keep these entries** (Hydro-specific benchmarks):
```toml
[[bench]]
name = "micro_ops"
harness = false

[[bench]]
name = "symmetric_hash_join"
harness = false

[[bench]]
name = "words_diamond"
harness = false

[[bench]]
name = "futures"
harness = false
```

### Update benches/Cargo.toml Dependencies

**Remove these dependencies** (only needed for timely/differential benchmarks):
```toml
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
timely = { package = "timely-master", version = "0.13.0-dev.1" }
```

**Keep these dependencies** (needed for remaining Hydro benchmarks):
```toml
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
futures = "0.3"
nameof = "1.0.0"
rand = "0.8.0"
rand_distr = "0.4.3"
seq-macro = "0.2.0"
sinktools = { path = "../sinktools", version = "^0.0.1" }
static_assertions = "1.0.0"
tokio = { version = "1.29.0", features = [ "rt-multi-thread" ] }
```

### Update benches/build.rs

The `build.rs` file can remain as is, since it's still needed for the `fork_join` benchmark that exists in... wait, `fork_join.rs` was migrated!

**Action:** Check if `build.rs` is still needed. If the `fork_join` benchmark was the only one using it:

```bash
# Check if any remaining benchmarks use the generated file
cd bigweaver-agent-canary-hydro-zeta/benches
grep -r "fork_join_.*\.hf" benches/

# If no results, remove build.rs
rm build.rs
```

If no remaining benchmarks use the generated files, **remove** `benches/build.rs`.

### Update benches/README.md

Replace the content with updated information about remaining benchmarks:

```markdown
# Microbenchmarks

Of Hydro (dfir_rs) core functionality.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Available Benchmarks

- **micro_ops** - Microbenchmarks of individual Hydro operators
- **symmetric_hash_join** - Symmetric hash join implementation benchmarks
- **words_diamond** - Diamond pattern dataflow benchmarks
- **futures** - Async/futures integration benchmarks

## Timely and Differential Dataflow Benchmarks

Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow have been moved to a separate repository for better organization:

**Repository:** `bigweaver-agent-canary-zeta-hydro-deps`

See the [bigweaver-agent-canary-zeta-hydro-deps repository](https://github.com/hydro-project/hydro-deps) for:
- Timely Dataflow benchmarks (arithmetic, fan_in, fan_out, fork_join, identity, join, upcase)
- Differential Dataflow benchmarks (reachability)

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
```

### Update Main README.md (if applicable)

If the main repository README mentions benchmarks, add a note about the separation:

```markdown
## Benchmarks

### Core Hydro Benchmarks

Core functionality benchmarks are in the `benches/` directory:

```bash
cargo bench -p benches
```

### Dependency Comparison Benchmarks

Benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow are maintained in a separate repository:

- Repository: [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/hydro-project/hydro-deps)
- Includes: timely dataflow benchmarks, differential dataflow benchmarks

See the separate repository for running cross-framework performance comparisons.
```

### Update CHANGELOG.md (if exists)

Add an entry describing the benchmark migration:

```markdown
## [Unreleased]

### Changed
- Moved timely and differential-dataflow benchmarks to separate `bigweaver-agent-canary-zeta-hydro-deps` repository for better separation of concerns
- Benchmarks directory now contains only Hydro-specific benchmarks (micro_ops, symmetric_hash_join, words_diamond, futures)
- Removed timely and differential-dataflow dependencies from benches package

### Removed
- arithmetic.rs benchmark (moved to hydro-deps)
- fan_in.rs benchmark (moved to hydro-deps)
- fan_out.rs benchmark (moved to hydro-deps)
- fork_join.rs benchmark (moved to hydro-deps)
- identity.rs benchmark (moved to hydro-deps)
- join.rs benchmark (moved to hydro-deps)
- upcase.rs benchmark (moved to hydro-deps)
- reachability.rs benchmark (moved to hydro-deps)

For migrated benchmarks, see: https://github.com/hydro-project/hydro-deps
```

### Update RELEASING.md (if applicable)

If there's a release documentation, note the benchmark separation:

```markdown
## Testing Releases

### Core Benchmarks
```bash
cargo bench -p benches
```

### Dependency Comparison Benchmarks
These are now in a separate repository. Clone and test:
```bash
git clone https://github.com/hydro-project/hydro-deps.git
cd hydro-deps
cargo bench -p timely-benchmarks
```
```

## Validation Steps

After making these changes:

1. **Verify Clean Build:**
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo clean
   cargo check -p benches
   cargo build -p benches
   ```

2. **Verify Remaining Benchmarks Work:**
   ```bash
   cargo bench -p benches --bench micro_ops
   cargo bench -p benches --bench symmetric_hash_join
   cargo bench -p benches --bench words_diamond
   cargo bench -p benches --bench futures
   ```

3. **Verify No References to Removed Files:**
   ```bash
   # Search for references to migrated benchmarks
   grep -r "arithmetic\|fan_in\|fan_out\|fork_join\|identity.*bench\|join.*bench\|upcase\|reachability" --include="*.md" --include="*.toml" --include="*.rs"
   ```

4. **Check Dependencies:**
   ```bash
   # Verify timely and differential-dataflow are not pulled in
   cargo tree -p benches | grep -i timely
   cargo tree -p benches | grep -i differential
   # Should return no results
   ```

## Git Commit Message

Following the team's conventional commit format:

```
feat(benches)!: move timely/differential benchmarks to separate repository (#XXXX)

Move timely and differential-dataflow benchmarks from benches/ to the new
bigweaver-agent-canary-zeta-hydro-deps repository for better separation
of concerns.

Removed benchmarks:
- arithmetic, fan_in, fan_out, fork_join, identity, join, upcase
- reachability (differential-dataflow)

Remaining benchmarks (Hydro-specific):
- micro_ops, symmetric_hash_join, words_diamond, futures

Breaking change: Benchmark commands changed for migrated benchmarks.
See MIGRATION.md in bigweaver-agent-canary-zeta-hydro-deps repository.

Related: companion PR in bigweaver-agent-canary-zeta-hydro-deps
```

## Timeline

1. Complete migration to new repository (✓ Done)
2. Test new repository benchmarks
3. Update original repository (this document)
4. Create companion PRs
5. Coordinate merge

## Rollback

If needed, to rollback:
1. Revert changes to original repository
2. Copy files back from new repository
3. Restore Cargo.toml entries
