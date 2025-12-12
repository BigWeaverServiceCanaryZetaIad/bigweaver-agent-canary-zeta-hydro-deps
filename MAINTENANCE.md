# Maintenance Guide

## Overview

This repository contains benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository. It maintains dependencies on the main repository through Cargo path dependencies.

## Dependencies on Main Repository

The benchmarks in this repository depend on the following packages from the main repository:

### Runtime Dependencies
- **hydro_lang** - Core language constructs and runtime
- **hydro_std** - Standard library including benchmark client utilities
- **stageleft** - Staging/metaprogramming support

### Build Dependencies
- **hydro_build_utils** - Build utilities and snapshot testing
- **stageleft_tool** - Build-time code generation

### Dev Dependencies (for examples and tests)
- **hydro_deploy** - Deployment infrastructure
- **dfir_lang** - Dataflow IR for graph generation
- **dfir_rs** - Dataflow runtime

## Keeping Benchmarks in Sync

### When Main Repository APIs Change

If the main repository changes APIs used by these benchmarks:

1. **Check Breaking Changes**:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   git log --grep="breaking" --oneline
   ```

2. **Update Benchmark Code**:
   - Update imports if module paths changed
   - Update function calls if signatures changed
   - Update types if they were modified

3. **Test Benchmarks**:
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo test
   ```

4. **Run Benchmarks**:
   ```bash
   cargo run --release --example paxos
   cargo run --release --example compartmentalized_paxos
   cargo run --release --example two_pc
   ```

### When Main Repository Versions Change

If the main repository updates version numbers:

1. **Update Cargo.toml**:
   Edit `hydro_test/Cargo.toml` and update version numbers in path dependencies:
   ```toml
   hydro_lang = { path = "../../bigweaver-agent-canary-hydro-zeta/hydro_lang", version = "^0.15.0" }
   ```

2. **Verify Compatibility**:
   ```bash
   cargo check
   cargo test
   ```

### Regular Maintenance Checklist

Perform these checks periodically (e.g., monthly):

- [ ] Run `cargo update` to update non-path dependencies
- [ ] Run `cargo test` to verify all tests pass
- [ ] Run all benchmark examples to ensure they execute correctly
- [ ] Check for deprecated API usage: `cargo clippy`
- [ ] Update documentation if behavior changed

## Troubleshooting

### Build Failures

**Problem**: Cargo can't find main repository packages

**Solution**: 
1. Verify main repository is at correct path: `../../bigweaver-agent-canary-hydro-zeta`
2. Check that required packages exist in main repository
3. Verify paths in `Cargo.toml` are correct

**Problem**: Version mismatch errors

**Solution**:
1. Check version requirements in `Cargo.toml`
2. Ensure main repository is on compatible version
3. Update version numbers if needed

### Runtime Failures

**Problem**: Benchmarks fail to start

**Solution**:
1. Check that required ports are available (8080, etc.)
2. Verify sufficient system resources
3. Review error messages for specific issues

**Problem**: Low or zero throughput

**Solution**:
1. Check system load (`top`, `htop`)
2. Verify network connectivity (especially for distributed tests)
3. Reduce `num_clients_per_node` parameter
4. Check logs for errors or warnings

### Test Failures

**Problem**: Snapshot tests fail

**Solution**:
1. Check if main repository IR generation changed
2. Review snapshot diffs to understand changes
3. Update snapshots if changes are intentional:
   ```bash
   cargo test -- --ignored  # Some snapshot tests may be ignored
   ```
4. Commit updated snapshots if appropriate

## Adding New Benchmarks

To add a new benchmark to this repository:

### 1. Create Benchmark Module

Create file in `hydro_test/src/cluster/<benchmark_name>.rs`:

```rust
use hydro_lang::prelude::*;
use hydro_std::bench_client::{bench_client, print_bench_results};

pub struct Client;
pub struct Aggregator;

pub fn my_benchmark<'a>(
    // benchmark parameters
    clients: &Cluster<'a, Client>,
    client_aggregator: &Process<'a, Aggregator>,
) {
    let bench_results = bench_client(
        clients,
        workload_generator,
        processor,
        num_clients_per_node,
        nondet!(/** bench */),
    );
    
    print_bench_results(bench_results, client_aggregator, clients);
}
```

### 2. Add Module Declaration

Add to `hydro_test/src/cluster/mod.rs`:
```rust
pub mod my_benchmark;
```

### 3. Create Example

Create file in `hydro_test/examples/<benchmark_name>.rs`:

```rust
use hydro_deploy::Deployment;
use hydro_lang::deploy::TrybuildHost;
use hydro_test_bench::cluster::my_benchmark::my_benchmark;

#[tokio::main]
async fn main() {
    let mut deployment = Deployment::new();
    let builder = hydro_lang::compile::builder::FlowBuilder::new();
    
    // Define locations
    let clients = builder.cluster();
    let client_aggregator = builder.process();
    
    // Run benchmark
    my_benchmark(&clients, &client_aggregator);
    
    // Deploy and run
    // ... deployment code ...
}
```

### 4. Register Example

Add to `hydro_test/Cargo.toml`:
```toml
[[example]]
name = "my_benchmark"
path = "examples/my_benchmark.rs"
```

### 5. Add Tests

Add tests to your benchmark module:
```rust
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn my_benchmark_ir() {
        // Test IR generation
    }
    
    #[tokio::test]
    async fn my_benchmark_some_throughput() {
        // Test actual throughput
    }
}
```

### 6. Update Documentation

- Add section to `README.md` describing the benchmark
- Add entry to `BENCHMARKS.md` with usage instructions
- Update this file if special maintenance is needed

## Version Control

### Commit Messages

Follow conventional commits format:
```
feat(bench): add new benchmark for protocol X
fix(paxos): correct checkpoint logic
docs(readme): update benchmark usage instructions
chore(deps): update dependency versions
```

### Branching Strategy

- `main` - Stable benchmarks
- `dev/<feature>` - New benchmark development
- `fix/<issue>` - Bug fixes

## Performance Baselines

Consider maintaining performance baselines for regression detection:

1. **Record Baselines**:
   ```bash
   cargo run --release --example paxos > baselines/paxos_$(date +%Y%m%d).txt
   ```

2. **Compare Performance**:
   - Track throughput trends over time
   - Investigate significant decreases
   - Document improvements from optimizations

3. **Automate Regression Detection**:
   - Set up CI to run benchmarks
   - Alert on >10% performance decrease
   - Require investigation before merge

## Related Repositories

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta`
- **Purpose**: Core Hydro language and runtime
- **Relationship**: This repository depends on main repository

## Contact and Support

For issues or questions:
1. Check main repository documentation
2. Review existing issues in main repository
3. Create new issue with `[benchmarks]` prefix if needed

## Future Improvements

Potential enhancements to consider:

- [ ] Automated performance regression testing
- [ ] More comprehensive benchmark suite
- [ ] Performance visualization dashboard
- [ ] Continuous benchmarking infrastructure
- [ ] Comparison tools for different configurations
- [ ] Benchmark result archival and analysis
