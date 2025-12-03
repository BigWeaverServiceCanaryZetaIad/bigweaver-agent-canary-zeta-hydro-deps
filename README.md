# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that have been separated from the main Hydro repository to maintain clean dependency management and reduce build times.

## Contents

### Hydro Benchmarks

Performance benchmarks for the Hydro distributed programming framework, including:

- Paxos consensus protocol benchmarks
- Two-phase commit (2PC) transaction coordination benchmarks
- Compartmentalized Paxos benchmarks
- Key-value store replica benchmarks

See [`hydro_benchmarks/README.md`](hydro_benchmarks/README.md) for detailed documentation.

## Purpose

This repository was created to:

1. **Maintain clean dependency management**: Keep benchmark-specific dependencies separate from the core Hydro framework
2. **Reduce compilation time**: Allow the main repository to build faster without benchmark code
3. **Enable performance comparisons**: Provide a dedicated space for performance testing infrastructure
4. **Follow architectural best practices**: Separate concerns between core functionality and testing/benchmarking

## Usage

### Running Benchmarks

```bash
cd hydro_benchmarks
cargo run --example paxos
cargo run --example two_pc
cargo run --example compartmentalized_paxos
```

For cloud deployment (GCP):

```bash
cargo run --example paxos -- --gcp <YOUR_GCP_PROJECT>
```

## Relationship to Main Repository

This repository complements the main Hydro repository:

- **Main Repository**: Core framework, language features, runtime, standard library
- **This Repository**: Performance benchmarks and testing infrastructure

## Contributing

When contributing benchmarks:

1. Follow the existing code organization patterns
2. Use `hydro_std::bench_client` for consistent metrics
3. Document benchmark parameters and expected results
4. Provide both local and cloud deployment configurations

## License

Apache-2.0 (same as the main Hydro project)
