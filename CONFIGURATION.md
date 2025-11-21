# Configuration Guide

This document explains how to configure the benchmark repository for different usage scenarios.

## Dependency Configuration

The repository can be configured to use dependencies in three different ways, depending on your needs.

### Option 1: Git Dependencies (Default)

**Use case**: Running benchmarks independently, without cloning the main repository.

**Pros**:
- Self-contained - no need for other repositories
- Always uses the latest code from upstream
- Easy to set up

**Cons**:
- Requires network access for initial build
- Build time includes compiling dependencies from source

**Configuration**: Already set as default in `Cargo.toml`

```toml
[dev-dependencies]
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main" }
```

### Option 2: Local Path Dependencies

**Use case**: Development alongside the main bigweaver-agent-canary-hydro-zeta repository, or testing local changes.

**Pros**:
- Fast builds after initial compilation
- Can test local modifications to dfir_rs or sinktools
- No network required after initial clone

**Cons**:
- Requires cloning and maintaining the main repository
- Must keep repositories in sync

**Setup**:

1. Clone both repositories side by side:
```bash
cd /projects/sandbox
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Update `Cargo.toml` to use local paths:
```toml
[dev-dependencies]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

### Option 3: Published Crate Dependencies

**Use case**: Using stable, published versions from crates.io.

**Pros**:
- Most reliable - uses tested, published versions
- Fastest initial build (no git cloning)
- Version pinning for reproducible builds

**Cons**:
- May not have latest features
- Requires crates to be published

**Configuration**:
```toml
[dev-dependencies]
dfir_rs = { version = "0.14.0", features = [ "debugging" ] }
sinktools = { version = "0.0.1" }
```

## Switching Between Configurations

To switch configurations:

1. Edit `Cargo.toml`
2. Comment out the current dependency lines
3. Uncomment the desired configuration
4. Run `cargo clean` to clear previous builds
5. Run `cargo check` to verify the new configuration

Example:
```toml
# Option 1: Git (Active)
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }

# Option 2: Local Path (Commented)
# dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }

# Option 3: Published (Commented)
# dfir_rs = { version = "0.14.0", features = [ "debugging" ] }
```

## Performance Considerations

### Build Performance

- **Git dependencies**: Slowest initial build, builds from source
- **Local path**: Fast after first build, uses workspace target directory
- **Published crates**: Fastest, pre-compiled by crates.io

### Runtime Performance

All three options produce identical runtime performance - the choice only affects build time.

## Troubleshooting

### Git Dependencies Not Resolving

**Issue**: `cargo build` fails with git fetch errors

**Solution**: 
- Check network connectivity
- Try with SSH keys: Change URL to `git@github.com:hydro-project/hydro.git`
- Use local path or published crates instead

### Local Path Not Found

**Issue**: `cargo build` fails with "path does not exist"

**Solution**:
- Verify the relative path is correct
- Ensure the main repository is cloned
- Check directory structure matches expected layout

### Version Mismatch

**Issue**: Build errors due to API changes

**Solution**:
- If using git: Pin to a specific commit with `rev = "abc123"`
- If using local: Update both repositories to matching versions
- If using published: Use compatible version numbers

## CI/CD Configuration

For continuous integration, git dependencies are recommended:

```yaml
# .github/workflows/benchmarks.yml
- name: Run benchmarks
  run: cargo bench --no-fail-fast
```

No additional setup needed - git dependencies work out of the box.

## Recommendations

- **For most users**: Use git dependencies (default)
- **For Hydro developers**: Use local path dependencies
- **For production/CI**: Use published crate dependencies when available

## Additional Resources

- [Cargo Book - Specifying Dependencies](https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html)
- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Project](https://hydro.run)
