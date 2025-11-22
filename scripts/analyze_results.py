#!/usr/bin/env python3
"""
Analyze Criterion benchmark results and generate comparison reports.

This script parses Criterion's JSON output and generates summaries
comparing Hydro, Timely, and Differential implementations.
"""

import json
import sys
from pathlib import Path
from typing import Dict, List, Tuple
from dataclasses import dataclass
from enum import Enum


class System(Enum):
    """Dataflow system being benchmarked."""
    HYDRO = "hydro"
    TIMELY = "timely"
    DIFFERENTIAL = "differential"
    BASELINE = "baseline"
    UNKNOWN = "unknown"


@dataclass
class BenchmarkResult:
    """Single benchmark result."""
    name: str
    system: System
    mean_ns: float
    std_dev_ns: float
    median_ns: float
    
    @property
    def mean_ms(self) -> float:
        """Mean time in milliseconds."""
        return self.mean_ns / 1_000_000
    
    @property
    def std_dev_ms(self) -> float:
        """Standard deviation in milliseconds."""
        return self.std_dev_ns / 1_000_000


def identify_system(benchmark_name: str) -> System:
    """Identify which system a benchmark is testing."""
    name_lower = benchmark_name.lower()
    
    if "hydro" in name_lower or "dfir" in name_lower:
        return System.HYDRO
    elif "differential" in name_lower:
        return System.DIFFERENTIAL
    elif "timely" in name_lower:
        return System.TIMELY
    elif any(x in name_lower for x in ["raw", "iter", "pipeline", "baseline"]):
        return System.BASELINE
    else:
        return System.UNKNOWN


def parse_criterion_json(criterion_dir: Path) -> List[BenchmarkResult]:
    """Parse Criterion JSON output files."""
    results = []
    
    # Find all estimates.json files
    for estimates_file in criterion_dir.rglob("estimates.json"):
        try:
            with open(estimates_file, 'r') as f:
                data = json.load(f)
            
            # Extract benchmark name from path
            # Path structure: criterion/<benchmark>/<variant>/base/estimates.json
            parts = estimates_file.parts
            if len(parts) >= 3:
                benchmark_name = f"{parts[-4]}/{parts[-3]}"
            else:
                benchmark_name = estimates_file.parent.parent.name
            
            # Extract statistics
            mean_ns = data.get("mean", {}).get("point_estimate", 0)
            std_dev_ns = data.get("std_dev", {}).get("point_estimate", 0)
            median_ns = data.get("median", {}).get("point_estimate", 0)
            
            system = identify_system(benchmark_name)
            
            result = BenchmarkResult(
                name=benchmark_name,
                system=system,
                mean_ns=mean_ns,
                std_dev_ns=std_dev_ns,
                median_ns=median_ns
            )
            
            results.append(result)
            
        except (json.JSONDecodeError, FileNotFoundError) as e:
            print(f"Warning: Could not parse {estimates_file}: {e}", file=sys.stderr)
            continue
    
    return results


def group_by_benchmark(results: List[BenchmarkResult]) -> Dict[str, List[BenchmarkResult]]:
    """Group results by benchmark name (without variant)."""
    grouped = {}
    
    for result in results:
        # Extract base benchmark name
        base_name = result.name.split('/')[0]
        
        if base_name not in grouped:
            grouped[base_name] = []
        
        grouped[base_name].append(result)
    
    return grouped


def format_time(ns: float) -> str:
    """Format nanoseconds in human-readable form."""
    if ns < 1_000:
        return f"{ns:.2f} ns"
    elif ns < 1_000_000:
        return f"{ns / 1_000:.2f} µs"
    elif ns < 1_000_000_000:
        return f"{ns / 1_000_000:.2f} ms"
    else:
        return f"{ns / 1_000_000_000:.2f} s"


def calculate_speedup(baseline: float, comparison: float) -> str:
    """Calculate speedup/slowdown percentage."""
    if baseline == 0:
        return "N/A"
    
    ratio = (comparison / baseline - 1) * 100
    
    if ratio > 0:
        return f"+{ratio:.1f}% slower"
    else:
        return f"{abs(ratio):.1f}% faster"


def print_comparison_table(benchmark_name: str, results: List[BenchmarkResult]):
    """Print comparison table for a single benchmark."""
    print(f"\n{'=' * 80}")
    print(f"Benchmark: {benchmark_name}")
    print('=' * 80)
    
    # Sort by mean time
    sorted_results = sorted(results, key=lambda r: r.mean_ns)
    
    # Find fastest for reference
    fastest = sorted_results[0] if sorted_results else None
    
    # Print header
    print(f"{'Variant':<40} {'Mean Time':<15} {'vs Fastest':<20} {'System':<12}")
    print('-' * 80)
    
    # Print results
    for result in sorted_results:
        system_name = result.system.value
        mean_time = format_time(result.mean_ns)
        
        if fastest and result.mean_ns > fastest.mean_ns:
            comparison = calculate_speedup(fastest.mean_ns, result.mean_ns)
        else:
            comparison = "baseline"
        
        variant_name = result.name.split('/', 1)[1] if '/' in result.name else result.name
        
        print(f"{variant_name:<40} {mean_time:<15} {comparison:<20} {system_name:<12}")
    
    # Print summary statistics
    print()
    print("Summary:")
    hydro_results = [r for r in sorted_results if r.system == System.HYDRO]
    timely_results = [r for r in sorted_results if r.system == System.TIMELY]
    differential_results = [r for r in sorted_results if r.system == System.DIFFERENTIAL]
    
    if hydro_results:
        avg_hydro = sum(r.mean_ns for r in hydro_results) / len(hydro_results)
        print(f"  Hydro average: {format_time(avg_hydro)}")
    
    if timely_results:
        avg_timely = sum(r.mean_ns for r in timely_results) / len(timely_results)
        print(f"  Timely average: {format_time(avg_timely)}")
        
        if hydro_results:
            avg_hydro = sum(r.mean_ns for r in hydro_results) / len(hydro_results)
            print(f"  Hydro vs Timely: {calculate_speedup(avg_timely, avg_hydro)}")
    
    if differential_results:
        avg_diff = sum(r.mean_ns for r in differential_results) / len(differential_results)
        print(f"  Differential average: {format_time(avg_diff)}")
        
        if hydro_results:
            avg_hydro = sum(r.mean_ns for r in hydro_results) / len(hydro_results)
            print(f"  Hydro vs Differential: {calculate_speedup(avg_diff, avg_hydro)}")


def print_system_comparison(all_results: List[BenchmarkResult]):
    """Print overall system comparison across all benchmarks."""
    print("\n" + "=" * 80)
    print("System Comparison - Average Performance Across All Benchmarks")
    print("=" * 80)
    
    # Group by system
    by_system = {}
    for result in all_results:
        if result.system not in by_system:
            by_system[result.system] = []
        by_system[result.system].append(result)
    
    # Calculate averages
    print(f"\n{'System':<20} {'Count':<10} {'Avg Time':<20}")
    print('-' * 50)
    
    for system in [System.HYDRO, System.TIMELY, System.DIFFERENTIAL, System.BASELINE]:
        if system in by_system:
            results = by_system[system]
            avg_time = sum(r.mean_ns for r in results) / len(results)
            print(f"{system.value:<20} {len(results):<10} {format_time(avg_time):<20}")


def main():
    """Main entry point."""
    if len(sys.argv) > 1:
        criterion_dir = Path(sys.argv[1])
    else:
        # Default location
        criterion_dir = Path(__file__).parent.parent / "target" / "criterion"
    
    if not criterion_dir.exists():
        print(f"Error: Criterion directory not found: {criterion_dir}", file=sys.stderr)
        print("Run benchmarks first with: ./scripts/run_benchmarks.sh", file=sys.stderr)
        sys.exit(1)
    
    print("Analyzing benchmark results...")
    print(f"Criterion directory: {criterion_dir}")
    
    # Parse results
    results = parse_criterion_json(criterion_dir)
    
    if not results:
        print("No benchmark results found.", file=sys.stderr)
        sys.exit(1)
    
    print(f"Found {len(results)} benchmark results")
    
    # Group by benchmark
    grouped = group_by_benchmark(results)
    
    # Print comparisons for each benchmark
    for benchmark_name in sorted(grouped.keys()):
        print_comparison_table(benchmark_name, grouped[benchmark_name])
    
    # Print overall system comparison
    print_system_comparison(results)
    
    print("\n" + "=" * 80)
    print("Analysis complete!")
    print("=" * 80)


if __name__ == "__main__":
    main()
