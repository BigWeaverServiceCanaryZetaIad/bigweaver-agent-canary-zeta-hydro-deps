# Microbenchmarks

Of Hydro and other crates, including timely and differential-dataflow performance comparisons.

## Background

These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate the timely and differential-dataflow dependencies. This separation allows the main repository to avoid carrying these dependencies while retaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Performance Comparisons

These benchmarks compare Hydro/DFIR performance against timely and differential-dataflow implementations. The results help validate optimizations and track performance over time.

## Integration with Main Repository

The benchmarks reference `dfir_rs` and `sinktools` from the main repository as git dependencies. This ensures they always test against the current state of the main codebase while keeping the dependency separation clean.

## Notes

- Wordlist for word-based benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Reachability benchmark includes pre-generated graph data files
