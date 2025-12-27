use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::fs;
use std::path::PathBuf;

#[derive(Debug, Serialize, Deserialize)]
struct BenchmarkResult {
    name: String,
    value: f64,
    unit: String,
}

#[derive(Debug, Serialize, Deserialize)]
struct ComparisonResult {
    benchmark: String,
    timely_result: Option<f64>,
    differential_result: Option<f64>,
    speedup_factor: Option<f64>,
    notes: Vec<String>,
}

/// Compare benchmark results between timely and differential implementations
fn main() {
    let args: Vec<String> = std::env::args().collect();
    
    if args.len() < 3 {
        eprintln!("Usage: {} <timely_results_dir> <differential_results_dir>", args[0]);
        eprintln!("Example: {} ./target/criterion/timely ./target/criterion/differential", args[0]);
        std::process::exit(1);
    }

    let timely_dir = PathBuf::from(&args[1]);
    let differential_dir = PathBuf::from(&args[2]);

    println!("=== Benchmark Comparison Tool ===\n");
    println!("Comparing results from:");
    println!("  Timely: {:?}", timely_dir);
    println!("  Differential: {:?}", differential_dir);
    println!();

    // Parse benchmark results
    let timely_results = parse_benchmark_results(&timely_dir, "timely");
    let differential_results = parse_benchmark_results(&differential_dir, "differential");

    // Compare results
    let comparisons = compare_results(&timely_results, &differential_results);

    // Display comparison
    display_comparison(&comparisons);

    // Export to JSON
    let output_path = "benchmark_comparison.json";
    let json = serde_json::to_string_pretty(&comparisons).unwrap();
    fs::write(output_path, json).expect("Failed to write comparison results");
    println!("\nComparison results exported to: {}", output_path);
}

fn parse_benchmark_results(dir: &PathBuf, prefix: &str) -> HashMap<String, f64> {
    let mut results = HashMap::new();
    
    // This is a simplified parser - in practice, you'd parse Criterion's output format
    // For now, we'll return mock data as an example
    println!("Parsing results from {:?}...", dir);
    
    // Mock data for demonstration
    results.insert(format!("{}/join/1000", prefix), 1234.5);
    results.insert(format!("{}/join/5000", prefix), 6789.0);
    
    results
}

fn compare_results(
    timely: &HashMap<String, f64>,
    differential: &HashMap<String, f64>,
) -> Vec<ComparisonResult> {
    let mut comparisons = Vec::new();
    
    // Collect all unique benchmark names
    let mut all_benchmarks = std::collections::HashSet::new();
    for key in timely.keys() {
        all_benchmarks.insert(key.split('/').skip(1).collect::<Vec<_>>().join("/"));
    }
    for key in differential.keys() {
        all_benchmarks.insert(key.split('/').skip(1).collect::<Vec<_>>().join("/"));
    }

    for benchmark in all_benchmarks {
        let timely_key = format!("timely/{}", benchmark);
        let differential_key = format!("differential/{}", benchmark);
        
        let timely_value = timely.get(&timely_key).copied();
        let differential_value = differential.get(&differential_key).copied();
        
        let speedup = match (timely_value, differential_value) {
            (Some(t), Some(d)) => Some(d / t),
            _ => None,
        };

        let mut notes = Vec::new();
        if timely_value.is_none() {
            notes.push("Missing timely result".to_string());
        }
        if differential_value.is_none() {
            notes.push("Missing differential result".to_string());
        }
        if let Some(s) = speedup {
            if s > 1.2 {
                notes.push("Differential significantly slower".to_string());
            } else if s < 0.8 {
                notes.push("Differential significantly faster".to_string());
            }
        }

        comparisons.push(ComparisonResult {
            benchmark: benchmark.to_string(),
            timely_result: timely_value,
            differential_result: differential_value,
            speedup_factor: speedup,
            notes,
        });
    }

    comparisons
}

fn display_comparison(comparisons: &[ComparisonResult]) {
    println!("\n=== Benchmark Comparison Results ===\n");
    println!("{:<40} {:>15} {:>15} {:>12} {}", 
        "Benchmark", "Timely (ns)", "Differential (ns)", "Speedup", "Notes");
    println!("{}", "-".repeat(100));

    for comp in comparisons {
        let timely_str = comp.timely_result
            .map(|v| format!("{:.2}", v))
            .unwrap_or_else(|| "N/A".to_string());
        
        let differential_str = comp.differential_result
            .map(|v| format!("{:.2}", v))
            .unwrap_or_else(|| "N/A".to_string());
        
        let speedup_str = comp.speedup_factor
            .map(|v| format!("{:.2}x", v))
            .unwrap_or_else(|| "N/A".to_string());
        
        let notes_str = if comp.notes.is_empty() {
            "OK".to_string()
        } else {
            comp.notes.join(", ")
        };

        println!("{:<40} {:>15} {:>15} {:>12} {}", 
            comp.benchmark, timely_str, differential_str, speedup_str, notes_str);
    }

    // Summary statistics
    println!("\n{}", "=".repeat(100));
    let valid_comparisons: Vec<_> = comparisons
        .iter()
        .filter(|c| c.speedup_factor.is_some())
        .collect();

    if !valid_comparisons.is_empty() {
        let avg_speedup: f64 = valid_comparisons
            .iter()
            .map(|c| c.speedup_factor.unwrap())
            .sum::<f64>() / valid_comparisons.len() as f64;

        println!("Average speedup factor: {:.2}x", avg_speedup);
        println!("Total benchmarks compared: {}", valid_comparisons.len());
    } else {
        println!("No valid comparisons available");
    }
}
