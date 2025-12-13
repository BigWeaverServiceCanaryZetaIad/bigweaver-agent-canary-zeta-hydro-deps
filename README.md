# bigweaver-agent-canary-zeta-hydro-deps

This repository contains external dependencies and benchmarks that have been separated from the main bigweaver-agent-canary-hydro-zeta repository to keep the main codebase lean and focused.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks comparing DFIR with timely-dataflow and differential-dataflow. These benchmarks were moved here to avoid including timely and differential-dataflow as dependencies in the main repository.

See [benches/README.md](benches/README.md) for more information about running and maintaining the benchmarks.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Performance benchmarks
│   ├── benches/               # Benchmark implementations
│   ├── Cargo.toml
│   └── README.md
├── Cargo.toml                 # Workspace configuration
└── README.md
```

## Prerequisites

This repository should be cloned alongside the main repository:

```
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/     # Main repository
  └── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

The benchmarks reference code from the main repository via relative paths.

## Usage

### Running Benchmarks

From this repository root:

```bash
cd benches
cargo bench
```

See the [benches README](benches/README.md) for more details.

## Relationship with Main Repository

This repository maintains external dependencies (timely, differential-dataflow) that are used for performance comparison purposes. The main bigweaver-agent-canary-hydro-zeta repository no longer has these dependencies, keeping it focused on core functionality.

## Contributing

When contributing to this repository:
1. Ensure benchmarks remain compatible with the main repository
2. Update documentation when adding new benchmarks
3. Follow the same code style and conventions as the main repository
4. Document any significant performance findings

## License

Apache-2.0 - See the main repository for full license details.