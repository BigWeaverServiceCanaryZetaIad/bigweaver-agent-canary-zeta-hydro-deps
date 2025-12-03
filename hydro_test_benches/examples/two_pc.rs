// Example demonstrating how to run the Two-Phase Commit benchmark
//
// This example shows how to set up and execute the two-phase commit protocol benchmark.
// It creates a coordinator, participants, and clients, and runs the benchmark to
// measure throughput.

use hydro_deploy::Deployment;
use hydro_lang::deploy::{DeployCrateWrapper, HydroDeploy, TrybuildHost};
use hydro_test_benches::two_pc::{Coordinator, Participant};
use hydro_test_benches::two_pc_bench::{two_pc_bench, Client, Aggregator};

const NUM_PARTICIPANTS: usize = 3;
const NUM_CLIENTS_PER_NODE: usize = 100;

#[cfg(stageleft_runtime)]
#[tokio::main]
async fn main() {
    // Create deployment
    let mut deployment = Deployment::new();
    let localhost = deployment.Localhost();

    // Set up processes and clusters for the different roles
    let builder = hydro_lang::FlowBuilder::new();
    let coordinator = builder.process::<Coordinator>();
    let participants = builder.cluster::<Participant>();
    let clients = builder.cluster::<Client>();
    let client_aggregator = builder.process::<Aggregator>();

    // Run the Two-Phase Commit benchmark
    two_pc_bench(
        NUM_CLIENTS_PER_NODE,
        &coordinator,
        &participants,
        NUM_PARTICIPANTS,
        &clients,
        &client_aggregator,
    );

    println!("Two-Phase Commit benchmark example completed");
}

#[cfg(not(stageleft_runtime))]
fn main() {
    println!("This example requires the stageleft_runtime feature to be enabled.");
    println!("Please build with: cargo run --example two_pc --features stageleft_runtime");
}
