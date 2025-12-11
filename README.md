# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for performance comparisons between Hydro/DFIR and external dataflow frameworks (timely-dataflow and differential-dataflow).

## Purpose

This repository was created to isolate benchmarks that depend on timely-dataflow and differential-dataflow from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. This separation:

- Reduces unnecessary dependencies in the main repository
- Keeps the main codebase focused on Hydro/DFIR development
- Maintains the ability to run performance comparisons
- Provides a dedicated space for external dependency benchmarks

## Contents

### Benchmarks

The `benches` directory contains performance comparison benchmarks:

- **arithmetic.rs** - Arithmetic operations pipeline
- **fan_in.rs** - Fan-in pattern
- **fan_out.rs** - Fan-out pattern  
- **fork_join.rs** - Fork-join pattern
- **identity.rs** - Identity transformation
- **join.rs** - Join operations
- **reachability.rs** - Graph reachability (uses differential-dataflow)
- **upcase.rs** - String uppercase transformation

Each benchmark includes implementations using both Hydro/DFIR and timely/differential-dataflow for direct performance comparison.

## Quick Start

**New to benchmarking?** See [QUICKSTART.md](QUICKSTART.md) for a 5-minute guide.

### Prerequisites

- Rust toolchain (1.70 or later recommended)
- Git access to the main bigweaver-agent-canary-hydro-zeta repository
- Cargo and standard Rust build tools

### Running Benchmarks

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# View HTML reports
open target/criterion/report/index.html
```

For detailed instructions, see [benches/README.md](benches/README.md).

## Performance Comparisons

**Want to compare DFIR vs timely/differential?** See [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) for comprehensive comparison techniques.

To compare performance between frameworks:

1. **Run benchmarks in this repository:**
   ```bash
   cargo bench
   ```

2. **Run benchmarks in the main repository:**
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

3. **Compare results:**
   - This repository: `target/criterion/`
   - Main repository: `target/criterion/`

Both repositories use consistent criterion configuration for fair comparisons.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml              # Workspace configuration
├── README.md               # This file
└── benches/                # Benchmark package
    ├── Cargo.toml          # Benchmark dependencies
    ├── README.md           # Detailed benchmark documentation
    ├── build.rs            # Build script
    └── benches/            # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        └── reachability_reachable.txt
```

## Dependencies

This repository depends on:

- **timely-master** - Timely dataflow framework
- **differential-dataflow-master** - Differential dataflow framework  
- **dfir_rs** - DFIR runtime (from main repository)
- **criterion** - Benchmarking framework

Dependencies on the main repository are referenced via git URLs to avoid workspace coupling.

## Contributing

When contributing:

1. Ensure benchmarks include both DFIR and timely/differential implementations
2. Follow existing code style and conventions
3. Update documentation for new benchmarks
4. Test benchmarks compile and run successfully
5. Use consistent naming and structure

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro/DFIR repository
- [hydro-project/hydro](https://github.com/hydro-project/hydro) - Upstream Hydro project

## License

Apache-2.0

## Migration History

These benchmarks were moved from the main repository in December 2025 to reduce dependencies and improve repository organization. For migration details, see the main repository's commit history.