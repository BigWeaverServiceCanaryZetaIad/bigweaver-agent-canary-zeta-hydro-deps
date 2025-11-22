#!/usr/bin/env bash
# Track performance over time
# Saves results with timestamps and generates trend reports

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Performance tracking directory
PERF_DIR="${REPO_ROOT}/.performance_history"
mkdir -p "$PERF_DIR"

usage() {
    cat << EOF
Usage: $0 [COMMAND] [OPTIONS]

Track benchmark performance over time.

COMMANDS:
    record [NAME]      Record current performance (default: auto-named by timestamp)
    list               List all recorded performance snapshots
    compare A B        Compare two performance snapshots
    trend BENCHMARK    Show performance trend for specific benchmark
    report             Generate full performance report
    clean              Clean old performance data

OPTIONS:
    -h, --help         Show this help message

EXAMPLES:
    # Record current performance
    $0 record

    # Record with custom name
    $0 record "after-optimization"

    # List all recordings
    $0 list

    # Compare two recordings
    $0 compare baseline-2024-01-15 current

    # Show trend for arithmetic benchmark
    $0 trend arithmetic

    # Generate report
    $0 report

EOF
}

# Generate timestamp-based name
generate_name() {
    date +"%Y-%m-%d_%H-%M-%S"
}

# Record current performance
record_performance() {
    local name="${1:-$(generate_name)}"
    local snapshot_dir="${PERF_DIR}/${name}"
    
    if [ -d "$snapshot_dir" ]; then
        echo -e "${YELLOW}Warning: Snapshot '$name' already exists${NC}"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cancelled"
            exit 0
        fi
        rm -rf "$snapshot_dir"
    fi
    
    mkdir -p "$snapshot_dir"
    
    echo -e "${BLUE}Recording performance snapshot: ${name}${NC}"
    echo ""
    
    # Run benchmarks
    cd "$REPO_ROOT"
    bash scripts/run_benchmarks.sh -m all -s "$name" || {
        echo -e "${RED}Benchmark run failed${NC}"
        exit 1
    }
    
    # Copy results
    if [ -d "target/criterion" ]; then
        echo -e "${BLUE}Saving results...${NC}"
        
        # Save metadata
        {
            echo "snapshot_name=$name"
            echo "timestamp=$(date -u +"%Y-%m-%d %H:%M:%S UTC")"
            echo "hostname=$(hostname)"
            echo "rust_version=$(rustc --version)"
            echo "git_commit=$(git -C ../bigweaver-agent-canary-hydro-zeta rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
        } > "$snapshot_dir/metadata.txt"
        
        # Extract key metrics
        find target/criterion -name "estimates.json" -type f | while read -r json_file; do
            bench_name=$(echo "$json_file" | sed 's|.*/criterion/||' | sed 's|/estimates.json||')
            mean=$(python3 -c "import json; data=json.load(open('$json_file')); print(data['mean']['point_estimate'])" 2>/dev/null || echo "0")
            echo "$bench_name,$mean" >> "$snapshot_dir/metrics.csv"
        done
        
        # Copy full criterion results
        cp -r target/criterion "$snapshot_dir/"
        
        echo -e "${GREEN}✓ Snapshot saved: ${snapshot_dir}${NC}"
        echo ""
        echo "To compare later:"
        echo "  $0 compare $name <other-snapshot>"
    else
        echo -e "${RED}No results found${NC}"
        exit 1
    fi
}

# List all snapshots
list_snapshots() {
    echo -e "${BLUE}Performance Snapshots${NC}"
    echo ""
    
    if [ ! -d "$PERF_DIR" ] || [ -z "$(ls -A "$PERF_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}No snapshots found${NC}"
        echo "Record your first snapshot with: $0 record"
        return
    fi
    
    echo -e "${GREEN}Name${NC}\t\t\t\t${GREEN}Timestamp${NC}\t\t\t${GREEN}Git Commit${NC}"
    echo "------------------------------------------------------------------------------------"
    
    for snapshot in "$PERF_DIR"/*; do
        if [ -d "$snapshot" ] && [ -f "$snapshot/metadata.txt" ]; then
            name=$(basename "$snapshot")
            timestamp=$(grep "^timestamp=" "$snapshot/metadata.txt" | cut -d= -f2)
            git_commit=$(grep "^git_commit=" "$snapshot/metadata.txt" | cut -d= -f2)
            
            printf "%-35s %-30s %s\n" "$name" "$timestamp" "$git_commit"
        fi
    done
    
    echo ""
    total=$(find "$PERF_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
    echo -e "${BLUE}Total snapshots: ${total}${NC}"
}

# Compare two snapshots
compare_snapshots() {
    local snap1="$1"
    local snap2="$2"
    
    local dir1="${PERF_DIR}/${snap1}"
    local dir2="${PERF_DIR}/${snap2}"
    
    if [ ! -d "$dir1" ]; then
        echo -e "${RED}Snapshot not found: $snap1${NC}"
        exit 1
    fi
    
    if [ ! -d "$dir2" ]; then
        echo -e "${RED}Snapshot not found: $snap2${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}Comparing Performance${NC}"
    echo -e "Baseline: ${GREEN}${snap1}${NC}"
    echo -e "Comparison: ${GREEN}${snap2}${NC}"
    echo ""
    
    if [ ! -f "$dir1/metrics.csv" ] || [ ! -f "$dir2/metrics.csv" ]; then
        echo -e "${RED}Metrics not found in one or both snapshots${NC}"
        exit 1
    fi
    
    # Compare metrics
    echo -e "${BLUE}Benchmark Performance Changes${NC}"
    echo "------------------------------------------------------------------------------------"
    printf "%-40s %-15s %-15s %s\n" "Benchmark" "Baseline" "Comparison" "Change"
    echo "------------------------------------------------------------------------------------"
    
    # Read both metric files and compare
    while IFS=, read -r bench1 mean1; do
        # Find corresponding benchmark in snap2
        mean2=$(grep "^${bench1}," "$dir2/metrics.csv" 2>/dev/null | cut -d, -f2 || echo "")
        
        if [ -n "$mean2" ] && [ "$mean1" != "0" ]; then
            # Calculate percentage change
            change=$(python3 -c "print(f'{((float($mean2) / float($mean1) - 1) * 100):.1f}')" 2>/dev/null || echo "N/A")
            
            # Format times
            time1=$(python3 -c "
m = float($mean1)
if m < 1000: print(f'{m:.2f} ns')
elif m < 1000000: print(f'{m/1000:.2f} µs')
elif m < 1000000000: print(f'{m/1000000:.2f} ms')
else: print(f'{m/1000000000:.2f} s')
" 2>/dev/null || echo "$mean1 ns")
            
            time2=$(python3 -c "
m = float($mean2)
if m < 1000: print(f'{m:.2f} ns')
elif m < 1000000: print(f'{m/1000:.2f} µs')
elif m < 1000000000: print(f'{m/1000000:.2f} ms')
else: print(f'{m/1000000000:.2f} s')
" 2>/dev/null || echo "$mean2 ns")
            
            # Color code the change
            if [ "$change" != "N/A" ]; then
                change_val=$(echo "$change" | sed 's/[^0-9.-]//g')
                if (( $(echo "$change_val < -5" | bc -l) )); then
                    change_display="${GREEN}${change}% (faster)${NC}"
                elif (( $(echo "$change_val > 5" | bc -l) )); then
                    change_display="${RED}${change}% (slower)${NC}"
                else
                    change_display="${YELLOW}${change}% (similar)${NC}"
                fi
            else
                change_display="N/A"
            fi
            
            printf "%-40s %-15s %-15s %s\n" "$(basename "$bench1")" "$time1" "$time2" "$change_display"
        fi
    done < "$dir1/metrics.csv"
    
    echo ""
}

# Show trend for specific benchmark
show_trend() {
    local benchmark="$1"
    
    echo -e "${BLUE}Performance Trend: ${benchmark}${NC}"
    echo ""
    
    if [ ! -d "$PERF_DIR" ] || [ -z "$(ls -A "$PERF_DIR" 2>/dev/null)" ]; then
        echo -e "${YELLOW}No snapshots found${NC}"
        return
    fi
    
    echo -e "${GREEN}Snapshot${NC}\t\t\t${GREEN}Timestamp${NC}\t\t\t${GREEN}Mean Time${NC}"
    echo "------------------------------------------------------------------------------------"
    
    for snapshot in "$PERF_DIR"/*; do
        if [ -d "$snapshot" ] && [ -f "$snapshot/metrics.csv" ]; then
            name=$(basename "$snapshot")
            timestamp=$(grep "^timestamp=" "$snapshot/metadata.txt" | cut -d= -f2 2>/dev/null || echo "unknown")
            
            # Find benchmark in metrics
            mean=$(grep "^${benchmark}[,/]" "$snapshot/metrics.csv" 2>/dev/null | head -1 | cut -d, -f2 || echo "")
            
            if [ -n "$mean" ]; then
                # Format time
                time_str=$(python3 -c "
m = float($mean)
if m < 1000: print(f'{m:.2f} ns')
elif m < 1000000: print(f'{m/1000:.2f} µs')
elif m < 1000000000: print(f'{m/1000000:.2f} ms')
else: print(f'{m/1000000000:.2f} s')
" 2>/dev/null || echo "$mean ns")
                
                printf "%-30s %-30s %s\n" "$name" "$timestamp" "$time_str"
            fi
        fi
    done
    
    echo ""
}

# Generate full report
generate_report() {
    echo -e "${BLUE}Generating Performance Report${NC}"
    echo ""
    
    local report_file="${REPO_ROOT}/performance_report_$(date +%Y%m%d_%H%M%S).txt"
    
    {
        echo "Performance Report"
        echo "Generated: $(date)"
        echo "=========================================="
        echo ""
        
        echo "Available Snapshots:"
        list_snapshots
        
        echo ""
        echo "Latest Snapshot Details:"
        latest=$(ls -t "$PERF_DIR" 2>/dev/null | head -1)
        if [ -n "$latest" ]; then
            cat "$PERF_DIR/$latest/metadata.txt"
        fi
    } > "$report_file"
    
    echo -e "${GREEN}Report saved: ${report_file}${NC}"
}

# Clean old performance data
clean_old_data() {
    echo -e "${YELLOW}Clean Performance History${NC}"
    echo ""
    
    if [ ! -d "$PERF_DIR" ] || [ -z "$(ls -A "$PERF_DIR" 2>/dev/null)" ]; then
        echo "No data to clean"
        return
    fi
    
    total=$(find "$PERF_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
    size=$(du -sh "$PERF_DIR" | awk '{print $1}')
    
    echo "Total snapshots: $total"
    echo "Total size: $size"
    echo ""
    
    read -p "Delete all performance history? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$PERF_DIR"
        echo -e "${GREEN}Performance history cleaned${NC}"
    else
        echo "Cancelled"
    fi
}

# Main command dispatcher
case "${1:-}" in
    record)
        record_performance "${2:-}"
        ;;
    list)
        list_snapshots
        ;;
    compare)
        if [ $# -lt 3 ]; then
            echo -e "${RED}Error: compare requires two snapshot names${NC}"
            usage
            exit 1
        fi
        compare_snapshots "$2" "$3"
        ;;
    trend)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: trend requires benchmark name${NC}"
            usage
            exit 1
        fi
        show_trend "$2"
        ;;
    report)
        generate_report
        ;;
    clean)
        clean_old_data
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo -e "${RED}Error: Unknown command: ${1:-}${NC}"
        echo ""
        usage
        exit 1
        ;;
esac

exit 0
