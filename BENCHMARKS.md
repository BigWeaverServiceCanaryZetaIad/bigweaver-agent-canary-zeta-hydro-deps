# Benchmark Quick Reference

## Available Benchmarks

### 1. Paxos Benchmark
**File**: `hydro_test/src/cluster/paxos_bench.rs`  
**Example**: `hydro_test/examples/paxos.rs`

Tests the throughput and performance of the Paxos consensus protocol implementation.

**Configuration Parameters**:
- `num_clients_per_node`: Number of virtual clients per node (default: 100)
- `checkpoint_frequency`: Sequence numbers before checkpointing (default: 1000)
- `f`: Maximum faulty nodes (default: 1)
- `num_replicas`: Total replicas (typically f+1, default: 2)

**Run Command**:
```bash
cargo run --release --example paxos
```

**Expected Output**: Throughput measurements in requests/second

---

### 2. Compartmentalized Paxos Benchmark
**File**: Uses `paxos_bench.rs` with compartmentalized variant  
**Example**: `hydro_test/examples/compartmentalized_paxos.rs`

Tests the compartmentalized Paxos variant with proxy leaders and acceptor grid.

**Configuration Parameters**:
- `num_clients_per_node`: Number of virtual clients per node (default: 100)
- `num_proxy_leaders`: Number of proxy leader nodes (default: 10)
- `acceptor_grid_rows`: Grid rows for acceptors (default: 2)
- `acceptor_grid_cols`: Grid columns for acceptors (default: 2)
- `num_replicas`: Total replicas (default: 4)

**Run Command**:
```bash
cargo run --release --example compartmentalized_paxos
```

**Expected Output**: Throughput measurements for compartmentalized architecture

---

### 3. Two-Phase Commit (2PC) Benchmark
**File**: `hydro_test/src/cluster/two_pc_bench.rs`  
**Example**: `hydro_test/examples/two_pc.rs`

Tests the throughput and performance of the Two-Phase Commit protocol.

**Configuration Parameters**:
- `num_clients_per_node`: Number of virtual clients per node (default: 100)
- `num_participants`: Number of participant nodes (default: 3)

**Run Command**:
```bash
cargo run --release --example two_pc
```

**Expected Output**: Throughput measurements in requests/second

---

## Common Options

All benchmarks support the following command-line options:

### GCP Deployment
Deploy to Google Cloud Platform instead of localhost:
```bash
cargo run --release --example <benchmark> -- --gcp your-project-name
```

### Graph Generation
Generate Mermaid visualization graphs:
```bash
cargo run --release --example <benchmark> -- --graph-mermaid output.mmd
cargo run --release --example <benchmark> -- --graph-dot output.dot
```

### Help
Display all available options:
```bash
cargo run --release --example <benchmark> -- --help
```

---

## Understanding Output

All benchmarks output throughput in the format:
```
Throughput: <lower> - <median> - <upper> requests/s
```

Where:
- **lower**: Lower bound of measured throughput
- **median**: Median throughput across measurements
- **upper**: Upper bound of measured throughput

The benchmark typically takes 2 measurements before completing.

---

## Benchmark Components

### Supporting Modules

#### `kv_replica.rs`
Key-value store replica used by Paxos benchmarks to process sequenced payloads.

#### `paxos.rs` (CorePaxos)
Core Paxos consensus protocol implementation with:
- Leader election
- Proposal sequencing
- Acceptor log storage
- Checkpoint management

#### `paxos_with_client.rs` (PaxosLike trait)
Client interface for Paxos protocol, allowing benchmarks to submit payloads.

#### `compartmentalized_paxos.rs`
Variant of Paxos with compartmentalized architecture using proxy leaders and acceptor grids.

#### `two_pc.rs`
Two-Phase Commit protocol with coordinator and participant roles.

### Workload Generator

#### `inc_u32_workload_generator`
Used by all benchmarks to generate incrementing u32 values as workload payloads.

---

## Running Tests

Run all benchmark tests:
```bash
cargo test
```

Run specific benchmark tests:
```bash
cargo test paxos_ir                    # Test Paxos IR generation
cargo test paxos_some_throughput      # Test Paxos throughput
cargo test two_pc_ir                   # Test 2PC IR generation
cargo test two_pc_some_throughput     # Test 2PC throughput
```

---

## Performance Tuning

### Localhost Deployment
For best localhost performance:
1. Ensure sufficient CPU cores (4+ recommended)
2. Minimize background processes
3. Use release build (`--release` flag)

### GCP Deployment
For GCP deployments:
1. Choose appropriate machine types (e.g., `n2-standard-4`, `n2-highcpu-2`)
2. Select regions close to your location
3. Ensure GCP quotas allow required number of VMs

### Optimization Flags
The examples use aggressive optimization flags:
```rust
let rustflags = "-C opt-level=3 -C codegen-units=1 -C strip=none -C debuginfo=2 -C lto=off";
```

---

## Troubleshooting

### Low Throughput
- Check system resources (CPU, memory, network)
- Reduce `num_clients_per_node` if overloaded
- Verify no other processes competing for resources

### Connection Timeouts
- Increase timeout values in configuration
- Check network connectivity (especially for GCP)
- Ensure required ports are available

### Build Errors
- Verify main repository is at `../../bigweaver-agent-canary-hydro-zeta`
- Check Rust version matches workspace requirements (edition 2024)
- Run `cargo clean` and rebuild

---

## Further Reading

- Main repository documentation: `../../bigweaver-agent-canary-hydro-zeta/README.md`
- Hydro language guide: See main repository docs
- Deployment options: See `hydro_deploy` documentation
