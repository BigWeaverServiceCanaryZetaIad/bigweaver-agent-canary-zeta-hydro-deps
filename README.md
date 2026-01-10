# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks and their dependencies for the Hydro project, separated from the main repository to maintain a cleaner codebase structure.

## Contents

### Benchmarks (`benches/`)
Performance benchmarks comparing HydroFlow (dfir_rs) with timely-dataflow and differential-dataflow implementations:
- `fan_in.rs` - Fan-in pattern benchmarks
- `fan_out.rs` - Fan-out pattern benchmarks  
- `reachability.rs` - Graph reachability benchmarks
- Additional micro-benchmarks and comparison tests

### Dependencies
The following dependencies are included to support benchmark compilation:
- `dfir_rs` - HydroFlow runtime
- `dfir_lang` - HydroFlow language implementation
- `dfir_macro` - HydroFlow macros
- `lattices` - Lattice types for distributed systems
- `sinktools` - Sink utilities
- `variadics` - Variadic type support
- And other supporting crates

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench fan_in
```

## Related Repositories

This repository is part of the Hydro project ecosystem:
- Main repository: `bigweaver-agent-canary-hydro-zeta`
