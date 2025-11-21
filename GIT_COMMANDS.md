# Git Commands for Committing Changes

This document provides the git commands to commit and push the migrated benchmarks.

## Initial Commit

### 1. Check Status
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
git status
```

### 2. Stage All Files
```bash
# Add all new files
git add .

# Verify what will be committed
git status
```

### 3. Create Initial Commit
```bash
git commit -m "feat: migrate timely and differential-dataflow benchmarks

- Migrate all 12 benchmark implementations from bigweaver-agent-canary-hydro-zeta
- Include test data files (reachability, words)
- Set up workspace configuration with proper dependencies
- Add GitHub Actions workflow for automated benchmarking
- Create comprehensive documentation (README, SETUP, BENCHMARKS, MIGRATION_GUIDE)
- Configure git dependencies for dfir_rs
- Retain all performance comparison functionality

Benchmarks included:
- arithmetic.rs - Arithmetic operations
- fan_in.rs - Stream merging patterns
- fan_out.rs - Stream splitting patterns  
- fork_join.rs - Parallel distribution/aggregation
- futures.rs - Async operation handling
- identity.rs - Baseline overhead measurement
- join.rs - Two-way stream joins
- micro_ops.rs - Individual operator benchmarks
- reachability.rs - Graph reachability (comprehensive comparison)
- symmetric_hash_join.rs - Bidirectional join operations
- upcase.rs - String processing benchmarks
- words_diamond.rs - Complex string pipeline

All performance comparison functionality between Timely, Differential, and DFIR
(scheduled and compiled) has been retained and properly configured."
```

### 4. Push to Remote
```bash
# Push to main branch
git push origin main

# Or if main doesn't exist yet, create it
git branch -M main
git push -u origin main
```

## Verifying the Push

### Check Remote Repository
```bash
# View remote configuration
git remote -v

# Check what was pushed
git log --oneline -n 5
```

### Verify on GitHub
After pushing, verify on GitHub:
1. Go to: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
2. Check that all files are present
3. Verify the commit message is correct
4. Check that GitHub Actions workflow is detected

## File List to Verify

After pushing, these files should be visible in the repository:

```
Root level:
- .gitignore
- BENCHMARKS.md
- Cargo.toml
- COMPLETION_SUMMARY.md
- GIT_COMMANDS.md
- MIGRATION_GUIDE.md
- README.md
- SETUP.md

.github/workflows/:
- benchmark.yml

benches/:
- Cargo.toml
- README.md
- build.rs

benches/benches/:
- .gitignore
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- futures.rs
- identity.rs
- join.rs
- micro_ops.rs
- reachability.rs
- reachability_edges.txt (521 KB)
- reachability_reachable.txt (38 KB)
- symmetric_hash_join.rs
- upcase.rs
- words_alpha.txt (3.7 MB)
- words_diamond.rs
```

## Triggering First Benchmark Run

After pushing, you can trigger the benchmark workflow:

### Option 1: Manual Trigger
1. Go to GitHub repository
2. Click "Actions" tab
3. Select "benchmark" workflow
4. Click "Run workflow"
5. Set should_bench to "true"
6. Click "Run workflow" button

### Option 2: Push with Tag
```bash
# Make a small change (e.g., update README)
echo "" >> README.md
git add README.md
git commit -m "docs: trigger initial benchmark run [ci-bench]"
git push origin main
```

The `[ci-bench]` tag in the commit message will trigger the benchmark workflow.

## Creating a Pull Request (Optional)

If you want to test the PR benchmark functionality:

```bash
# Create a new branch
git checkout -b test-benchmarks

# Make a change
echo "# Test" >> BENCHMARKS.md
git add BENCHMARKS.md
git commit -m "test: verify PR benchmarks [ci-bench]"

# Push branch
git push origin test-benchmarks

# Then create PR on GitHub with [ci-bench] in title or description
```

## Subsequent Updates

For future updates:

```bash
# Make changes
# ...

# Stage changes
git add <files>

# Commit with descriptive message
git commit -m "type: description

Details about the change"

# Push
git push origin main
```

### Commit Message Types
- `feat:` - New feature or benchmark
- `fix:` - Bug fix
- `docs:` - Documentation only changes
- `perf:` - Performance improvement
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks
- `ci:` - CI/CD changes

## Troubleshooting

### Push Rejected
If push is rejected:
```bash
# Pull latest changes first
git pull origin main --rebase

# Then push
git push origin main
```

### Wrong Remote
If remote is not configured:
```bash
# Add remote
git remote add origin https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Verify
git remote -v
```

### Large Files Warning
The words_alpha.txt file is 3.7 MB. If Git warns about large files:
```bash
# It should be fine, but if needed, you can use Git LFS
git lfs track "*.txt"
git add .gitattributes
git commit -m "chore: configure Git LFS for large files"
```

## Backup Commands

Before pushing, create a backup:
```bash
# Create a backup branch
git branch backup-$(date +%Y%m%d)

# Or create a tag
git tag -a v0.1.0 -m "Initial migration"
```

## Summary

The essential commands are:
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
git add .
git commit -m "feat: migrate timely and differential-dataflow benchmarks"
git push origin main
```

After pushing, verify on GitHub and trigger the first benchmark run to ensure everything works correctly.
