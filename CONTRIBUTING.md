# Contributing to Hydro Benchmarks

Thank you for your interest in contributing benchmark implementations for the Hydro distributed programming framework!

## Repository Purpose

This repository contains performance benchmark implementations for Hydro protocols. It is separate from the main Hydro repository to:
- Maintain clean dependency management
- Enable independent versioning of benchmark code
- Reduce compilation overhead for non-benchmark development workflows

## Structure

```
hydro_benchmarks/
├── src/
│   ├── lib.rs              # Module exports and re-exports
│   ├── paxos_bench.rs      # Paxos consensus benchmark
│   ├── two_pc_bench.rs     # Two-Phase Commit benchmark
│   └── kv_replica.rs       # Key-value replica (benchmark utility)
```

## Adding a New Benchmark

### 1. Create the Benchmark Implementation

Create a new file in `hydro_benchmarks/src/` (e.g., `my_protocol_bench.rs`):

```rust
use hydro_lang::prelude::*;
use hydro_std::bench_client::{bench_client, print_bench_results};

pub struct Client;
pub struct Aggregator;

pub fn my_protocol_bench<'a>(
    num_clients_per_node: usize,
    // ... other parameters
) {
    // Benchmark implementation using bench_client
    let bench_results = bench_client(
        clients,
        workload_generator,
        transaction_processor,
        num_clients_per_node,
        nondet!(/** bench */),
    );

    print_bench_results(bench_results, client_aggregator, clients);
}
```

### 2. Update lib.rs

Add your module to `hydro_benchmarks/src/lib.rs`:

```rust
pub mod my_protocol_bench;
```

### 3. Add Tests

Include tests in your benchmark file:

```rust
#[cfg(test)]
mod tests {
    use hydro_deploy::Deployment;
    use hydro_lang::deploy::TrybuildHost;

    #[tokio::test]
    async fn my_protocol_some_throughput() {
        // Test implementation
    }
}
```

### 4. Create an Example in Main Repository

Add a deployment example in the main repository at `hydro_test/examples/my_protocol.rs`:

```rust
use hydro_benchmarks::my_protocol_bench::my_protocol_bench;

#[tokio::main]
async fn main() {
    // Deployment configuration
    // Call to my_protocol_bench
}
```

### 5. Update Documentation

- Add your benchmark to the README.md in this repository
- Update BENCHMARKS_MIGRATION.md in the main repository if relevant

## Testing Your Benchmark

### Local Testing

```bash
# Run tests in this repository
cargo test

# Run your benchmark via example in main repository
cd ../bigweaver-agent-canary-hydro-zeta
cargo run --example my_protocol
```

### Using the Helper Script

```bash
# Add your benchmark to run_benchmarks.sh
./run_benchmarks.sh my-protocol
```

## Code Style

- Follow the existing Rust style guidelines
- Use `rustfmt` for formatting: `cargo fmt`
- Check with `clippy`: `cargo clippy`
- Configuration files (`rustfmt.toml`, `clippy.toml`) are provided

## Dependencies

This repository depends on the main Hydro repository. When adding new benchmarks:

1. **Protocol Implementations**: Should remain in the main repository if they're used by non-benchmark code
2. **Benchmark-Specific Code**: Should be added to this repository
3. **Shared Utilities**: Consider whether they belong in `hydro_std` (main repo) or here

### Current Dependencies

- `hydro_lang` - Core Hydro language framework
- `hydro_std` - Standard library (includes `bench_client`)
- `hydro_test` - Protocol implementations used by benchmarks

## Performance Metrics

Benchmarks should measure:
- **Throughput**: Requests per second
- **Latency**: Distribution of request latencies (using HDR histogram)
- **Scalability**: Performance across different cluster sizes

Use the `bench_client` infrastructure from `hydro_std` which provides:
- Concurrent client simulation
- Latency histogram tracking
- Throughput calculation
- Result aggregation

## Questions?

- For benchmark-specific questions, file an issue in this repository
- For protocol implementation questions, file an issue in the main repository
- For general Hydro questions, visit [hydro.run](https://hydro.run)

## License

This project is licensed under the Apache-2.0 License.
