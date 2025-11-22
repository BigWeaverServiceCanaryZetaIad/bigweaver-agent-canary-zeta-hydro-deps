#!/bin/bash
# Setup script for local development with Hydro benchmarks
# This script configures the repository to use local Hydro dependencies

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYDRO_REPO_DEFAULT="../bigweaver-agent-canary-hydro-zeta"

echo "==================================="
echo "Hydro Benchmarks Local Dev Setup"
echo "==================================="
echo

# Check if Hydro repository path is provided
if [ -z "$1" ]; then
    HYDRO_REPO="$HYDRO_REPO_DEFAULT"
    echo "Using default Hydro repository path: $HYDRO_REPO"
    echo "To specify a different path, run: $0 /path/to/bigweaver-agent-canary-hydro-zeta"
else
    HYDRO_REPO="$1"
    echo "Using specified Hydro repository path: $HYDRO_REPO"
fi

echo

# Check if Hydro repository exists
if [ ! -d "$HYDRO_REPO" ]; then
    echo "❌ Error: Hydro repository not found at: $HYDRO_REPO"
    echo
    echo "Please clone the Hydro repository first:"
    echo "  git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git $HYDRO_REPO"
    exit 1
fi

# Verify it's the correct repository
if [ ! -f "$HYDRO_REPO/dfir_rs/Cargo.toml" ]; then
    echo "❌ Error: $HYDRO_REPO doesn't appear to be a valid Hydro repository"
    echo "   (dfir_rs/Cargo.toml not found)"
    exit 1
fi

echo "✅ Found Hydro repository at: $HYDRO_REPO"
echo

# Get absolute path
HYDRO_REPO_ABS=$(cd "$HYDRO_REPO" && pwd)

# Calculate relative path from benches directory
BENCHES_DIR="$SCRIPT_DIR/benches"
RELATIVE_PATH=$(python3 -c "import os.path; print(os.path.relpath('$HYDRO_REPO_ABS', '$BENCHES_DIR'))" 2>/dev/null || \
                realpath --relative-to="$BENCHES_DIR" "$HYDRO_REPO_ABS" 2>/dev/null || \
                echo "$HYDRO_REPO")

echo "Updating benches/Cargo.toml to use local dependencies..."

# Backup original Cargo.toml
cp "$SCRIPT_DIR/benches/Cargo.toml" "$SCRIPT_DIR/benches/Cargo.toml.backup"

# Update Cargo.toml with local paths
sed -i.tmp \
    -e "s|dfir_rs = { git = \"https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git\", features = \[ \"debugging\" \] }|dfir_rs = { path = \"$RELATIVE_PATH/dfir_rs\", features = [ \"debugging\" ] }|g" \
    -e "s|sinktools = { git = \"https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git\" }|sinktools = { path = \"$RELATIVE_PATH/sinktools\" }|g" \
    "$SCRIPT_DIR/benches/Cargo.toml"

# Remove temporary file created by sed
rm -f "$SCRIPT_DIR/benches/Cargo.toml.tmp"

echo "✅ Updated benches/Cargo.toml with local paths"
echo "   Backup saved to: benches/Cargo.toml.backup"
echo

# Test the configuration
echo "Testing configuration..."
if cargo check -p benches --quiet 2>/dev/null; then
    echo "✅ Configuration successful! Cargo check passed."
else
    echo "⚠️  Warning: Cargo check reported some issues. This might be normal if dependencies need building."
    echo "   Try running: cargo build -p benches"
fi

echo
echo "==================================="
echo "Setup complete!"
echo "==================================="
echo
echo "Your benchmark repository is now configured to use local Hydro dependencies from:"
echo "  $HYDRO_REPO_ABS"
echo
echo "You can now:"
echo "  1. Make changes to Hydro code in: $HYDRO_REPO"
echo "  2. Run benchmarks: cargo bench -p benches"
echo "  3. Test specific benchmarks: cargo bench -p benches --bench identity"
echo
echo "To restore git dependencies, run:"
echo "  mv benches/Cargo.toml.backup benches/Cargo.toml"
echo

exit 0
