# Quick Start Guide

## Prerequisites

Ensure you have:
- Rust toolchain installed (edition 2024 support)
- Both repositories cloned in the same parent directory:
  ```
  parent-directory/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
  ```

## First Time Setup

1. **Navigate to this repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Verify the main repository is accessible**:
   ```bash
   ls ../bigweaver-agent-canary-hydro-zeta
   ```

3. **Build the project**:
   ```bash
   cargo build --release
   ```

## Running Your First Benchmark

### Paxos Benchmark (Localhost)

The simplest benchmark to start with:

```bash
cargo run --release --example paxos
```

**Expected behavior**:
1. Build process completes (may take a few minutes first time)
2. Deployment starts on localhost
3. Benchmark runs and outputs throughput measurements
4. Press Ctrl+C to stop when done

**Expected output**:
```
Throughput: 1234.5 - 2345.6 - 3456.7 requests/s
Throughput: 1235.0 - 2346.0 - 3457.0 requests/s
```

### Two-Phase Commit Benchmark (Localhost)

```bash
cargo run --release --example two_pc
```

### Compartmentalized Paxos Benchmark (Localhost)

```bash
cargo run --release --example compartmentalized_paxos
```

## Running Tests

Verify everything works:

```bash
cargo test
```

## Common Issues

### "Cannot find hydro_lang"
**Problem**: Main repository not found  
**Solution**: Verify path `../bigweaver-agent-canary-hydro-zeta` exists

### "Port already in use"
**Problem**: Previous benchmark still running  
**Solution**: 
```bash
# Find and kill process
lsof -i :8080
kill <PID>
```

### Build takes very long
**Problem**: First build compiles many dependencies  
**Solution**: This is normal, subsequent builds will be faster

### Low throughput
**Problem**: System overloaded or incorrect configuration  
**Solution**: 
- Close other applications
- Check system resources
- Try reducing `num_clients_per_node` in the example file

## Next Steps

1. **Understand the output**: See [BENCHMARKS.md](BENCHMARKS.md) for details on interpreting results

2. **Try different configurations**: Edit the example files to change parameters

3. **Run on GCP**: Follow GCP deployment instructions in [README.md](README.md)

4. **Add new benchmarks**: See [MAINTENANCE.md](MAINTENANCE.md) for guide

## Quick Reference

| Command | Purpose |
|---------|---------|
| `cargo build --release` | Build all benchmarks |
| `cargo test` | Run all tests |
| `cargo run --release --example paxos` | Run Paxos benchmark |
| `cargo run --release --example two_pc` | Run 2PC benchmark |
| `cargo run --release --example compartmentalized_paxos` | Run compartmentalized Paxos |
| `cargo clean` | Clean build artifacts |
| `cargo doc --open` | Generate and view documentation |

## Getting Help

1. Check [README.md](README.md) for detailed documentation
2. Check [BENCHMARKS.md](BENCHMARKS.md) for benchmark-specific help
3. Check [MAINTENANCE.md](MAINTENANCE.md) for maintenance issues
4. Review logs and error messages
5. Check main repository documentation

## Performance Tips

For best benchmark results:

1. **Use release mode**: Always use `--release` flag
2. **Close other apps**: Minimize background processes
3. **Run multiple times**: Take average of several runs
4. **Warm up**: First run may be slower
5. **Monitor resources**: Use `htop` or similar to check system load

## Validation

Verify your setup is working correctly:

```bash
# 1. Build succeeds
cargo build --release

# 2. Tests pass
cargo test

# 3. Benchmark runs and outputs throughput
timeout 30 cargo run --release --example two_pc &
# Should see "Throughput:" in output

# 4. No errors in compilation
cargo check 2>&1 | grep -i error
# Should output nothing
```

If all validation steps pass, your setup is ready!
