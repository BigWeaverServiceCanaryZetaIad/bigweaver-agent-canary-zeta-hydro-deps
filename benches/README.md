# Comparative Benchmarks

Benchmarks comparing DFIR with timely-dataflow and differential-dataflow.

## Prerequisites

This repository contains benchmarks that compare DFIR implementations with timely-dataflow and differential-dataflow. The benchmarks depend on the main bigweaver-agent-canary-hydro-zeta repository.

Ensure both repositories are cloned at the same level:
```
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
```

## Available Benchmarks

- **arithmetic** - Arithmetic operations across multiple stages
- **fan_in** - Multiple inputs merging to single output
- **fan_out** - Single input splitting to multiple outputs
- **fork_join** - Parallel processing with synchronization
- **futures** - Asynchronous operations benchmarks
- **identity** - Passthrough operations
- **join** - Relational join operations
- **micro_ops** - Fine-grained operation benchmarks
- **reachability** - Graph reachability computations
- **symmetric_hash_join** - Hash-based join operations
- **upcase** - String transformation operations
- **words_diamond** - Complex word processing pipelines

## Notes

- Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- These benchmarks include comparisons with timely-dataflow and differential-dataflow, which are not dependencies of the main repository
