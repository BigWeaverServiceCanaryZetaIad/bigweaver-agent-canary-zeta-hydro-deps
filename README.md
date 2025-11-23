# bigweaver-agent-canary-zeta-hydro-deps

Companion repository for performance benchmarks and dependency-heavy components of the Hydroflow project.

## Purpose

This repository serves as a dedicated space for:

- **Performance Benchmarks**: Timely and differential-dataflow benchmarks comparing with Hydroflow (dfir_rs)
- **Dependency Isolation**: Heavy dependencies that aren't required for core development
- **Performance Analysis**: Tools and scripts for comparing performance across implementations

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark suite
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Arithmetic operations comparison
│   │   ├── fan_in.rs          # Fan-in pattern benchmark
│   │   ├── fan_out.rs         # Fan-out pattern benchmark
│   │   ├── fork_join.rs       # Fork-join pattern benchmark
│   │   ├── identity.rs        # Identity/baseline benchmark
│   │   ├── join.rs            # Join operations benchmark
│   │   ├── reachability.rs    # Graph reachability benchmark
│   │   ├── upcase.rs          # String transformation benchmark
│   │   ├── reachability_edges.txt      # Test data for reachability
│   │   └── reachability_reachable.txt  # Expected results for reachability
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Detailed benchmark documentation
├── Cargo.toml                # Workspace configuration
└── README.md                 # This file
```

## Rationale

This repository was created to address several architectural goals:

### 1. Dependency Separation
The main Hydroflow repository (`bigweaver-agent-canary-hydro-zeta`) focuses on core functionality. By moving benchmarks that depend on timely and differential-dataflow here, we:
- Reduce compilation time for core development
- Simplify the dependency tree
- Minimize dependency conflicts
- Enable faster CI/CD pipelines for main development

### 2. Performance Comparison
Despite the separation, we maintain the ability to:
- Compare Hydroflow performance against industry-standard implementations (Timely, Differential)
- Track performance trends over time
- Identify optimization opportunities
- Validate performance improvements

### 3. Modular Architecture
Following microservice principles:
- Clear separation of concerns
- Independent versioning and releases
- Isolated testing and benchmarking
- Flexible deployment options

## Quick Start

### Prerequisites

- Rust toolchain (matching main repository version)
- Git access to the main repository (for dfir_rs dependencies)

### Running Benchmarks

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p timely-differential-benches

# Run specific benchmark
cargo bench -p timely-differential-benches --bench arithmetic

# Run with specific filter
cargo bench -p timely-differential-benches --bench arithmetic -- dfir
```

### Viewing Results

Benchmark results are saved in `target/criterion/` with detailed HTML reports:

```bash
# Open benchmark results
open target/criterion/report/index.html
```

## Available Benchmarks

| Benchmark | Description | Implementations |
|-----------|-------------|-----------------|
| `arithmetic` | Basic arithmetic operations | Hydroflow, Timely, Raw, Iterator |
| `fan_in` | Multiple inputs to single output | Hydroflow, Timely |
| `fan_out` | Single input to multiple outputs | Hydroflow, Timely |
| `fork_join` | Parallel computation with sync | Hydroflow, Timely |
| `identity` | Baseline dataflow overhead | Hydroflow (compiled/interpreted), Timely |
| `join` | Relational join operations | Hydroflow, Timely |
| `reachability` | Graph traversal algorithms | Hydroflow, Differential |
| `upcase` | String transformation | Hydroflow, Timely |

For detailed benchmark documentation, see [`benches/README.md`](benches/README.md).

## Integration with Main Repository

This repository maintains close integration with the main Hydroflow repository:

### Dependencies
- `dfir_rs`: Referenced as git dependency from main repository
- `sinktools`: Referenced as git dependency from main repository

### Workflow
1. Changes to Hydroflow APIs in main repository automatically affect benchmarks
2. Benchmark results inform optimization decisions in main repository
3. Performance regressions are detected through comparative analysis

### Coordinated Changes
When making architectural changes:
1. Update main repository for core functionality
2. Update benchmarks in this repository if APIs change
3. Verify performance impact using benchmarks
4. Document findings in both repositories

## Performance Comparison Methodology

These benchmarks follow a rigorous methodology:

### 1. Comparative Testing
Each benchmark includes implementations across multiple frameworks:
- **Hydroflow (dfir_rs)**: The system under test
- **Timely/Differential**: Industry standard baselines
- **Raw/Iterator**: Theoretical performance limits

### 2. Statistical Analysis
Using Criterion framework for:
- Multiple iterations for statistical significance
- Outlier detection and removal
- Confidence intervals
- Regression analysis

### 3. Realistic Workloads
Benchmarks use:
- Real-world data patterns (e.g., graph data for reachability)
- Configurable workload sizes
- Various computation patterns

## Continuous Integration

### Recommended CI Setup

```yaml
name: Performance Benchmarks

on:
  schedule:
    - cron: "0 0 * * 0"  # Weekly
  workflow_dispatch:

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Rust
        uses: actions-rs/toolchain@v1
      - name: Run benchmarks
        run: cargo bench -p timely-differential-benches
      - name: Upload results
        uses: actions/upload-artifact@v4
        with:
          name: benchmark-results
          path: target/criterion/
```

## Maintenance

### Updating Benchmarks
When Hydroflow APIs change:
1. Check benchmark compilation: `cargo check -p timely-differential-benches`
2. Update benchmark code as needed
3. Re-run benchmarks to establish new baselines
4. Document API changes affecting benchmarks

### Adding New Benchmarks
1. Create benchmark file in `benches/benches/`
2. Add `[[bench]]` entry in `benches/Cargo.toml`
3. Update `benches/README.md`
4. Add entry to this README's benchmark table
5. Run and validate: `cargo bench -p timely-differential-benches --bench <name>`

### Performance Regression Investigation
If regression detected:
1. Compare with historical data in `target/criterion/`
2. Profile specific variants: `cargo bench --bench <name> -- --profile-time=5`
3. Review recent changes in main repository
4. Document findings and create issues

## Contributing

When contributing to this repository:

1. **Code Style**: Follow Rust conventions and existing patterns
2. **Benchmarks**: Ensure statistical validity and comparative fairness
3. **Documentation**: Update READMEs for any changes
4. **Testing**: Verify benchmarks compile and run successfully
5. **Coordination**: Consider impact on main repository integration

## Related Repositories

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta` - Core Hydroflow implementation
- **Documentation**: Performance comparison results and analysis

## Migration History

This repository was created as part of a refactoring effort to:
- Separate benchmark dependencies from core development
- Improve build times and developer experience
- Maintain performance comparison capabilities
- Enable independent evolution of benchmarks

See the main repository's `REMOVAL_SUMMARY.md` for detailed migration history.

## License

Apache-2.0 (matches main repository)

## Contact

For questions, issues, or contributions, please refer to the main repository's issue tracker or contact the Hydroflow team.