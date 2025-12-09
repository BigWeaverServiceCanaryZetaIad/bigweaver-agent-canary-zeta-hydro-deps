# Setup Instructions

## First-Time Setup

After cloning this repository, you need to generate the `Cargo.lock` file and verify the setup.

### Prerequisites

1. Rust toolchain (see `rust-toolchain.toml` for the required version)
2. Network access to GitHub (for Git dependencies) and crates.io

### Generate Cargo.lock

```bash
# Generate the lock file
cargo generate-lockfile

# Or simply build the project (which will generate the lock file automatically)
cargo build -p benches
```

### Verify Setup

```bash
# Check that all dependencies can be resolved
cargo check -p benches

# Run a quick benchmark to verify everything works
cargo bench -p benches --bench arithmetic -- --quick
```

## Troubleshooting

### Git Dependency Issues

If you encounter issues with Git dependencies from the main Hydro repository:

1. **Using a specific commit**:
   Edit `benches/Cargo.toml` and add a `rev` parameter:
   ```toml
   dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", rev = "COMMIT_SHA", features = [ "debugging" ] }
   ```

2. **Using a local checkout** (for development):
   Edit `benches/Cargo.toml` to use path dependencies:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

### Build Errors

If you encounter build errors:

1. Ensure you're using the correct Rust toolchain (run `rustup show`)
2. Clear the build cache: `cargo clean`
3. Update dependencies: `cargo update`
4. Check that the main Hydro repository is accessible

### Network Issues

If you're behind a proxy or firewall:

1. Configure Git to use your proxy:
   ```bash
   git config --global http.proxy http://proxy.example.com:8080
   git config --global https.proxy https://proxy.example.com:8080
   ```

2. Configure Cargo to use your proxy:
   ```bash
   # In ~/.cargo/config.toml
   [http]
   proxy = "proxy.example.com:8080"
   
   [https]
   proxy = "proxy.example.com:8080"
   ```

## Development Workflow

### Testing Local Changes

To test changes from a local checkout of the main Hydro repository:

1. Clone both repositories side-by-side:
   ```
   parent-dir/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Modify `benches/Cargo.toml` to use path dependencies (see above)

3. Make changes in the main repository

4. Run benchmarks: `cargo bench -p benches`

5. Before committing, revert `benches/Cargo.toml` to use Git dependencies

### Running Benchmarks in CI/CD

See the main repository's documentation for setting up automated benchmark runs.

## Next Steps

After setup, see [README.md](README.md) for information on running and adding benchmarks.
