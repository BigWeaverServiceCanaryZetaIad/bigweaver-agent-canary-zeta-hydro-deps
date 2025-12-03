# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that rely on timely-dataflow and differential-dataflow packages.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that depend on timely and differential-dataflow packages. These benchmarks test various dataflow patterns and operations:

- **Dataflow patterns**: identity, fan_in, fan_out, fork_join, join
- **Applications**: reachability, words_diamond, upcase
- **System operations**: arithmetic, micro_ops, symmetric_hash_join, futures

For more information on running benchmarks, see [benches/README.md](benches/README.md).

## Relationship to Main Repository

This repository was separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to isolate heavy dependencies (timely and differential-dataflow) from the core codebase. This separation:

- Reduces build times for the main repository
- Maintains the ability to run performance comparisons
- Allows independent management of benchmark infrastructure
- Prevents unnecessary dependencies in the core project

The benchmarks reference the main repository via git dependencies to access necessary crates like `dfir_rs` and `sinktools`.