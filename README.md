# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies that are isolated from the main bigweaver-agent-canary-hydro-zeta repository to prevent direct dependencies on certain packages.

## Benchmarks

This repository includes performance benchmarks for Hydro and other frameworks (Timely, Differential Dataflow).

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
```

Available benchmarks:
- arithmetic
- fan_in
- fan_out
- fork_join
- futures
- identity
- join
- micro_ops
- reachability
- symmetric_hash_join
- upcase
- words_diamond