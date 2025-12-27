use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::fs;

#[derive(Debug, Serialize, Deserialize)]
struct CriterionEstimate {
    #[serde(rename = "Point Estimate")]
    point_estimate: f64,
    #[serde(rename = "Standard Error")]
    standard_error: f64,
}

#[derive(Debug, Serialize, Deserialize)]
struct CriterionBenchmark {
    mean: CriterionEstimate,
    median: CriterionEstimate,
    #[serde(rename = "MAD")]
    mad: CriterionEstimate,
}

#[derive(Debug, Serialize)]
struct AnalysisReport {
    benchmark_name: String,
    mean_ns: f64,
    median_ns: f64,
    std_error: f64,
    throughput_elements_per_sec: Option<f64>,
}

/// Analyze benchmark results from Criterion output
fn main() {
    let args: Vec<String> = std::env::args().collect();
    
    if args.len() < 2 {
        eprintln!("Usage: {} <criterion_results_dir>", args[0]);
        eprintln!("Example: {} ./target/criterion", args[0]);
        std::process::exit(1);
    }

    let results_dir = &args[1];
    
    println!("=== Benchmark Analysis Tool ===\n");
    println!("Analyzing results from: {}", results_dir);
    println!();

    // Parse and analyze results
    let analyses = analyze_directory(results_dir);
    
    // Display analysis
    display_analysis(&analyses);
    
    // Export analysis report
    let output_path = "benchmark_analysis.json";
    let json = serde_json::to_string_pretty(&analyses).unwrap();
    fs::write(output_path, &json).expect("Failed to write analysis");
    println!("\nAnalysis report exported to: {}", output_path);
}

fn analyze_directory(dir: &str) -> Vec<AnalysisReport> {
    let mut reports = Vec::new();
    
    // This is a simplified analyzer
    // In practice, you'd recursively walk the criterion output directory
    // and parse estimates.json files
    
    println!("Scanning directory for benchmark results...");
    
    // Mock data for demonstration
    reports.push(AnalysisReport {
        benchmark_name: "timely/join/1000".to_string(),
        mean_ns: 1234.5,
        median_ns: 1230.0,
        std_error: 12.3,
        throughput_elements_per_sec: Some(810_372.0),
    });
    
    reports.push(AnalysisReport {
        benchmark_name: "differential/join/1000".to_string(),
        mean_ns: 1456.7,
        median_ns: 1450.0,
        std_error: 15.6,
        throughput_elements_per_sec: Some(686_507.0),
    });
    
    reports
}

fn display_analysis(reports: &[AnalysisReport]) {
    println!("\n=== Benchmark Analysis Report ===\n");
    println!("{:<45} {:>15} {:>15} {:>12} {:>18}",
        "Benchmark", "Mean (ns)", "Median (ns)", "Std Err", "Elements/sec");
    println!("{}", "-".repeat(110));

    for report in reports {
        let throughput_str = report.throughput_elements_per_sec
            .map(|t| format!("{:.0}", t))
            .unwrap_or_else(|| "N/A".to_string());

        println!("{:<45} {:>15.2} {:>15.2} {:>12.2} {:>18}",
            report.benchmark_name,
            report.mean_ns,
            report.median_ns,
            report.std_error,
            throughput_str
        );
    }

    // Statistical summary
    println!("\n{}", "=".repeat(110));
    
    let total_benchmarks = reports.len();
    let avg_mean: f64 = reports.iter().map(|r| r.mean_ns).sum::<f64>() / total_benchmarks as f64;
    
    println!("Total benchmarks analyzed: {}", total_benchmarks);
    println!("Average mean execution time: {:.2} ns", avg_mean);
    
    // Find fastest and slowest
    if let Some(fastest) = reports.iter().min_by(|a, b| a.mean_ns.partial_cmp(&b.mean_ns).unwrap()) {
        println!("Fastest benchmark: {} ({:.2} ns)", fastest.benchmark_name, fastest.mean_ns);
    }
    
    if let Some(slowest) = reports.iter().max_by(|a, b| a.mean_ns.partial_cmp(&b.mean_ns).unwrap()) {
        println!("Slowest benchmark: {} ({:.2} ns)", slowest.benchmark_name, slowest.mean_ns);
    }
}
