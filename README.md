# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on `timely` and `differential-dataflow` packages, which have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository clean and avoid unnecessary dependencies.

## Benchmarks

The benchmarks in this repository can be used to run performance comparisons with the main repository.

### Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

### Available Benchmarks

- `arithmetic`: Arithmetic operations benchmarks
- `fan_in`: Fan-in pattern benchmarks
- `fan_out`: Fan-out pattern benchmarks
- `fork_join`: Fork-join pattern benchmarks
- `futures`: Futures benchmarks
- `identity`: Identity operation benchmarks
- `join`: Join operation benchmarks
- `micro_ops`: Micro-operations benchmarks
- `reachability`: Graph reachability benchmarks
- `symmetric_hash_join`: Symmetric hash join benchmarks
- `upcase`: String upcase benchmarks
- `words_diamond`: Words diamond pattern benchmarks

## Dependencies

This repository depends on:
- `timely-master`: For timely dataflow operations
- `differential-dataflow-master`: For differential dataflow operations
- `dfir_rs`: From the main repository (via git dependency)
- `sinktools`: From the main repository (via git dependency)

## Maintenance

The benchmarks are configured to reference specific commits from the main repository to ensure reproducibility. When the main repository is updated, these references may need to be updated to maintain compatibility.