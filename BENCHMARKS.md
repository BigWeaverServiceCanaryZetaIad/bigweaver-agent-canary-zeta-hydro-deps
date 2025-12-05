# Hydro Benchmarks

This repository contains benchmarks for distributed protocols implemented using the Hydro framework. These benchmarks measure performance characteristics including latency and throughput for consensus and transaction protocols.

## Available Benchmarks

### Paxos Consensus Benchmark

The Paxos benchmark measures the performance of the Paxos consensus protocol implementation with key-value store replicas.

**Location**: `hydro_benchmarks/src/cluster/paxos_bench.rs`

**Features**:
- Multi-replica consensus with configurable fault tolerance
- Key-value store operations with checkpointing
- Concurrent client workload generation
- Latency histogram tracking (p50, p99, p999)
- Throughput measurement with rolling averages

**Configuration Parameters**:
- `num_clients_per_node`: Number of concurrent clients per node
- `checkpoint_frequency`: Sequence numbers between checkpoints
- `f`: Maximum number of faulty nodes (quorum = f+1)
- `num_replicas`: Total number of replicas

**Usage Example**:
```rust
paxos_bench(
    100,              // clients per node
    1000,             // checkpoint frequency
    1,                // fault tolerance (f)
    3,                // number of replicas
    paxos,            // paxos implementation
    &clients,         // client cluster
    &client_aggregator, // aggregator process
    &replicas         // replica cluster
);
```

### Two-Phase Commit (2PC) Benchmark

The Two-PC benchmark measures the performance of the two-phase commit transaction protocol.

**Location**: `hydro_benchmarks/src/cluster/two_pc_bench.rs`

**Features**:
- Coordinator-participant transaction model
- Concurrent client transactions
- Commit/abort decision tracking
- Performance metrics collection

**Configuration Parameters**:
- `num_clients_per_node`: Number of concurrent clients per node
- `num_participants`: Number of participants in the protocol

**Usage Example**:
```rust
two_pc_bench(
    100,              // clients per node
    &coordinator,     // coordinator process
    &participants,    // participant cluster
    3,                // number of participants
    &clients,         // client cluster
    &client_aggregator // aggregator process
);
```

## Benchmark Framework

### Core Components

#### Benchmark Client (`bench_client/`)

The benchmark client framework provides infrastructure for running distributed benchmarks:

- **Workload Generation**: Generates concurrent workloads across multiple clients
- **Latency Measurement**: Records per-transaction latency using HDR histograms
- **Throughput Tracking**: Measures requests/second with rolling averages
- **Result Aggregation**: Collects and aggregates metrics from all clients
- **Result Display**: Formats and prints benchmark results

#### Supporting Protocols

- **Paxos** (`paxos.rs`): Full implementation of the Paxos consensus protocol
- **Two-Phase Commit** (`two_pc.rs`): 2PC transaction coordination
- **KV Replica** (`kv_replica.rs`): Key-value store with checkpointing
- **Quorum Utilities** (`quorum.rs`): Quorum collection and verification

## Running Benchmarks

### Build

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo build --release --package hydro_benchmarks
```

### Run Tests

```bash
# Run all benchmark tests
cargo test --package hydro_benchmarks

# Run specific benchmark
cargo test --package hydro_benchmarks paxos_bench
cargo test --package hydro_benchmarks two_pc_bench
```

### Performance Testing

For performance evaluation, use the release build with specific tests:

```bash
# Paxos throughput test
cargo test --release --package hydro_benchmarks paxos_some_throughput

# Two-PC throughput test  
cargo test --release --package hydro_benchmarks two_pc_some_throughput
```

## Understanding Results

### Latency Metrics

Latency is reported using percentiles from HDR histograms:
- **p50 (median)**: 50% of requests complete within this time
- **p99**: 99% of requests complete within this time
- **p999**: 99.9% of requests complete within this time

Example output:
```
Latency p50: 1.234 | p99 5.678 | p999 12.345 ms (10000 samples)
```

### Throughput Metrics

Throughput is reported as requests per second with confidence intervals:
```
Throughput: 1000.0 - 1500.0 - 2000.0 requests/s
```

This shows:
- Lower bound: 1000 req/s
- Average: 1500 req/s  
- Upper bound: 2000 req/s

## Performance Comparison

### Comparing Versions

To compare performance across different Hydro versions:

1. **Baseline Measurement**:
   ```bash
   # Check out baseline version
   cd bigweaver-agent-canary-hydro-zeta
   git checkout v0.13.0
   
   # In deps repo, update dependencies and run
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo test --release --package hydro_benchmarks -- --nocapture > baseline.txt
   ```

2. **New Version Measurement**:
   ```bash
   # Check out new version
   cd bigweaver-agent-canary-hydro-zeta
   git checkout v0.14.0
   
   # Run benchmarks again
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo test --release --package hydro_benchmarks -- --nocapture > new_version.txt
   ```

3. **Compare Results**:
   ```bash
   diff baseline.txt new_version.txt
   # Or use your preferred comparison tool
   ```

### Benchmark Configuration

For consistent comparisons:
- Use the same hardware/environment
- Run multiple iterations and average results
- Ensure no other heavy processes are running
- Use release builds only
- Record system specifications with results

## Development

### Adding New Benchmarks

1. **Create Benchmark File**:
   ```bash
   # Create in hydro_benchmarks/src/cluster/
   touch hydro_benchmarks/src/cluster/my_protocol_bench.rs
   ```

2. **Implement Benchmark**:
   ```rust
   use hydro_lang::prelude::*;
   use crate::bench_client::{bench_client, print_bench_results};
   
   pub fn my_protocol_bench<'a>(
       num_clients_per_node: usize,
       // ... other parameters
   ) {
       let bench_results = bench_client(
           clients,
           workload_generator,
           transaction_cycle,
           num_clients_per_node,
           nondet!(/** bench */),
       );
       
       print_bench_results(bench_results, aggregator, clients);
   }
   ```

3. **Add Module Declaration**:
   ```rust
   // In hydro_benchmarks/src/cluster/mod.rs
   pub mod my_protocol_bench;
   ```

4. **Add Tests**:
   ```rust
   #[cfg(test)]
   mod tests {
       #[tokio::test]
       async fn my_protocol_some_throughput() {
           // Test implementation
       }
   }
   ```

### Customizing Workloads

The benchmark framework supports custom workload generators:

```rust
fn custom_workload_generator(client_id: usize) -> impl FnMut() -> MyPayload {
    // Return closure that generates payloads
    move || {
        MyPayload {
            id: client_id,
            // ... generate payload
        }
    }
}
```

## Dependencies

### Required Crates

The benchmark crate depends on:
- `hydro_lang`: Core Hydro language features
- `hydro_std`: Standard Hydro utilities (for protocol implementations)
- `hydro_deploy`: Deployment framework (dev-dependencies)
- `hdrhistogram`: HDR histogram for latency tracking
- `tokio`: Async runtime
- `serde`: Serialization

### Version Requirements

See `Cargo.toml` for specific version requirements. Generally:
- Hydro crates: ^0.14.0
- External dependencies: Latest stable versions

## Troubleshooting

### Build Issues

**Problem**: Cannot find `hydro_lang` or other Hydro crates
**Solution**: Ensure the main Hydro repository is built or Hydro crates are published

**Problem**: Snapshot tests failing
**Solution**: Regenerate snapshots with `UPDATE_SNAPSHOTS=1 cargo test`

### Runtime Issues

**Problem**: Benchmarks timing out
**Solution**: Reduce `num_clients_per_node` or increase test timeout

**Problem**: Inconsistent throughput results
**Solution**: Run on dedicated hardware, increase warmup period

### Performance Issues

**Problem**: Lower than expected throughput
**Solution**: 
- Ensure using `--release` build
- Check system resource utilization
- Verify network latency is low (for distributed tests)
- Increase `num_clients_per_node` to drive higher load

## Contributing

When contributing benchmarks:

1. Follow existing code structure and patterns
2. Include comprehensive tests
3. Document benchmark parameters and expected behavior
4. Provide baseline performance numbers
5. Update this documentation

## References

- [Hydro Documentation](https://hydro.run)
- [Paxos Paper](https://lamport.azurewebsites.net/pubs/paxos-simple.pdf)
- [Two-Phase Commit](https://en.wikipedia.org/wiki/Two-phase_commit_protocol)
- [HDR Histogram](https://github.com/HdrHistogram/HdrHistogram_rust)
