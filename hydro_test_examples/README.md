# Benchmark Examples

This directory contains example programs that demonstrate running benchmarks with deployment.

## Files

- **paxos.rs** - Deploy and run Paxos consensus protocol benchmarks
- **two_pc.rs** - Deploy and run Two-Phase Commit protocol benchmarks  
- **compartmentalized_paxos.rs** - Deploy and run compartmentalized Paxos benchmarks

## Status

**Note**: These examples are reference implementations that have been moved from the main repository. They demonstrate how to deploy and run protocol benchmarks, but require the benchmark modules (`paxos_bench`, `two_pc_bench`) from `hydro_test_benches/` to be integrated into a proper package structure to compile.

These files serve as:
1. **Documentation** - Shows how benchmarks were deployed and configured
2. **Reference** - Template for creating new benchmark deployment examples
3. **Historical Record** - Preserves the deployment patterns used

## Integration Steps (for future work)

To make these examples functional:

1. **Create hydro_test_benches package**:
   - Convert standalone .rs files into a proper Rust package
   - Export `paxos_bench` and `two_pc_bench` modules
   - Add appropriate dependencies

2. **Update example dependencies**:
   - Add `hydro_test_benches` as a dependency
   - Update module paths in examples

3. **Test deployment**:
   - Verify local deployment works
   - Test GCP deployment functionality

## Prerequisites

If/when integrated, these examples will depend on:
- The main Hydro repository (`bigweaver-agent-canary-hydro-zeta`)
- The benchmark modules in `hydro_test_benches/` (need packaging)
- Protocol implementations from `hydro_test/src/cluster/` in the main repository

Ensure both repositories are cloned as siblings:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Configuration Reference

Each example has configurable parameters:

**Paxos & Compartmentalized Paxos:**
- `f` - Fault tolerance (number of failures to tolerate)
- `num_clients` - Number of client nodes
- `num_clients_per_node` - Virtual clients per physical node
- `checkpoint_frequency` - Log entries before checkpointing
- `i_am_leader_send_timeout` - Leader heartbeat timeout
- `i_am_leader_check_timeout` - Leader health check timeout

**Two-PC:**
- `num_participants` - Number of transaction participants
- `num_clients` - Number of client nodes
- `num_clients_per_node` - Virtual clients per physical node

## Deployment Patterns

These examples demonstrate:
- **Local deployment** using `deployment.Localhost()`
- **GCP deployment** using `GcpComputeEngineHost`
- **Graph generation** for visualization
- **Configuration management** for distributed protocols
- **Performance monitoring** with benchmarking utilities

## Notes

These examples were moved from the main repository's `hydro_test/examples/` directory as part of the benchmark migration (December 2025). They were preserved to document the deployment patterns and configuration approaches used for running protocol benchmarks.

For functional examples that don't depend on benchmarking functionality, see the main repository's `hydro_test/examples/` directory.
