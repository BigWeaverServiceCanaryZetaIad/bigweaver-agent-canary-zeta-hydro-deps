# Microbenchmarks

Benchmarks that depend on timely and differential-dataflow packages.

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench join
```
