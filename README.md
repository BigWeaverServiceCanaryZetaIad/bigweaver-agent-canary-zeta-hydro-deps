# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages, which have been extracted from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency management.

## Contents

### benches/
Performance benchmarks that use timely and differential-dataflow for comparison with the main Hydro implementation. These benchmarks include:
- arithmetic operations
- fan-in and fan-out patterns
- fork-join patterns
- futures integration
- identity operations
- join operations
- micro operations
- reachability analysis
- symmetric hash join
- upcase transformations
- word diamond pattern

### hydro_test_benches/
Benchmarks extracted from hydro_test that test distributed consensus algorithms:
- paxos_bench.rs - Paxos consensus benchmarks
- two_pc_bench.rs - Two-phase commit benchmarks

## Running Benchmarks

To run the benchmarks:

```bash
# Run all benches
cargo bench

# Run specific benchmark
cargo bench --bench identity

# Run with release optimizations
cargo bench --release
```

## Performance Comparisons

To run performance comparisons between the main repository and these benchmarks:

1. Clone both repositories:
```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Run benchmarks in each repository:
```bash
# In bigweaver-agent-canary-hydro-zeta
cd bigweaver-agent-canary-hydro-zeta
cargo test --release

# In bigweaver-agent-canary-zeta-hydro-deps  
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench --release
```

3. Compare results from the criterion output in `target/criterion/`.

## Dependencies

The benchmarks in this repository depend on:
- **timely-master** (0.13.0-dev.1) - Timely dataflow system
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow library
- **dfir_rs** - Referenced from main repository via git
- **sinktools** - Referenced from main repository via git
- **hydro_lang** - Referenced from main repository via git
- **hydro_std** - Referenced from main repository via git

These dependencies are intentionally kept separate from the main repository to avoid dependency bloat.

## Migration History

These benchmarks were moved from the main repository as part of the dependency cleanup effort to:
1. Reduce compilation time in the main repository
2. Avoid unnecessary dependencies in production code
3. Maintain the ability to run performance comparisons
4. Keep benchmark code organized and maintainable

## Documentation

For more information about the Hydro project, see the main repository:
https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git