# Quick Reference: Benchmark Locations After Migration

## Hydro-Only Benchmarks (Main Repository)
**Location:** `bigweaver-agent-canary-hydro-zeta/benches/benches/`

```bash
cd bigweaver-agent-canary-hydro-zeta

# Run all Hydro benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench futures
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
```

**Benchmarks:**
- `micro_ops.rs` - Hydro micro-operations (map, filter, join, etc.)
- `futures.rs` - Async futures benchmarks
- `symmetric_hash_join.rs` - Symmetric hash join operations
- `words_diamond.rs` - Diamond pattern with word processing

**Dependencies:** No external dataflow framework dependencies

---

## Comparison Benchmarks (Deps Repository)
**Location:** `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all comparison benchmarks
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench arithmetic
```

**Benchmarks:**
- `reachability.rs` - Graph reachability (Timely & Differential implementations)
- `join.rs` - Join operations comparison (usize & String types)
- `arithmetic.rs` - Arithmetic operations
- `fan_in.rs` - Fan-in dataflow patterns
- `fan_out.rs` - Fan-out dataflow patterns
- `fork_join.rs` - Fork-join patterns
- `identity.rs` - Identity transformations
- `upcase.rs` - String uppercase operations

**Dependencies:** Includes timely and differential-dataflow packages

---

## When to Use Which Repository

### Use Main Repository When:
- Developing Hydro-specific features
- Writing benchmarks that only test Hydro
- Contributing to core Hydro functionality
- You want fast builds without external framework dependencies

### Use Deps Repository When:
- Comparing Hydro performance with Timely/Differential
- Validating performance claims
- Running regression tests against other frameworks
- Analyzing relative performance characteristics

---

## Documentation

- **Main Repo Benchmarks:** `bigweaver-agent-canary-hydro-zeta/benches/README.md`
- **Deps Repo Benchmarks:** `bigweaver-agent-canary-zeta-hydro-deps/benches/README.md`
- **Migration Details:** `bigweaver-agent-canary-zeta-hydro-deps/BENCHMARK_MIGRATION.md`

---

## Common Tasks

### Add a new Hydro-only benchmark:
1. Create `*.rs` file in `bigweaver-agent-canary-hydro-zeta/benches/benches/`
2. Add `[[bench]]` entry to `bigweaver-agent-canary-hydro-zeta/benches/Cargo.toml`
3. Use only `dfir_rs`, `criterion`, and standard dependencies

### Add a new comparison benchmark:
1. Create `*.rs` file in `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`
2. Add `[[bench]]` entry to `bigweaver-agent-canary-zeta-hydro-deps/benches/Cargo.toml`
3. Use `timely`, `differential-dataflow`, and comparison logic

### Update framework versions:
- **Timely/Differential:** Only update in deps repository's `Cargo.toml`
- **Hydro/DFIR:** Update in main repository (automatically available to deps repo via path)
