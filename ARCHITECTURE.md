# Architecture Overview

This document describes the architecture of the benchmark suite and its relationship to the main Hydroflow repository.

## Repository Relationships

This repository (bigweaver-agent-canary-zeta-hydro-deps) works alongside the main Hydroflow repository (bigweaver-agent-canary-hydro-zeta) to provide comprehensive performance comparison capabilities.

### Design Rationale

The repositories are separated to:
- **Reduce build times**: Main repo doesn't need timely/differential dependencies
- **Isolate dependencies**: Prevent version conflicts
- **Maintain clarity**: Clear separation of benchmark implementations
- **Enable flexibility**: Each repo can evolve independently

## Key Components

### 1. Benchmark Suite
- 8 comprehensive benchmarks
- Multiple implementations per benchmark (timely, differential, baselines)
- Consistent naming for cross-repository comparison

### 2. Build System
- Cargo workspace configuration
- Makefile with 30+ convenient commands
- Criterion.rs integration for statistical analysis

### 3. Documentation
- Setup guides (SETUP.md)
- Benchmark details (BENCHMARKS.md)
- Best practices (BENCHMARKING_BEST_PRACTICES.md)
- Contributing guidelines (CONTRIBUTING.md)

### 4. Automation
- Comparison script (compare_benchmarks.sh)
- Regression detection (check_performance.sh)
- CI/CD workflows (GitHub Actions)

### 5. Dependencies
- timely-master 0.13.0-dev.1
- differential-dataflow-master 0.13.0-dev.1
- criterion 0.5.0
- Supporting libraries (futures, rand, tokio, etc.)

## Benchmark Architecture

Each benchmark follows a consistent structure:

1. **Configuration**: Constants defining data sizes and parameters
2. **Framework implementations**: Timely/differential dataflow code
3. **Baseline implementations**: Raw Rust, iterators, pipelines
4. **Criterion setup**: Benchmark registration and execution

## Performance Comparison Workflow

1. Developer runs benchmarks in deps repository
2. Developer runs benchmarks in main repository
3. Results compared using HTML reports or comparison tools
4. Analysis identifies performance characteristics and regressions

## Extensibility

The architecture supports:
- Adding new benchmarks
- Adding new implementations
- Integrating with additional tools
- Automated regression detection
- Historical performance tracking

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on extending the benchmark suite.
