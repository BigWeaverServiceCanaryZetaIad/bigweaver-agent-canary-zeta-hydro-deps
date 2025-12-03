// Example demonstrating how to run the Paxos benchmark
//
// This example shows how to set up and execute the Paxos consensus protocol benchmark.
// It creates a cluster of proposers, acceptors, clients, and replicas, and runs
// the benchmark to measure throughput.

use hydro_deploy::Deployment;
use hydro_lang::deploy::{DeployCrateWrapper, HydroDeploy, TrybuildHost};
use hydro_test_benches::paxos::{CorePaxos, PaxosConfig, Proposer, Acceptor};
use hydro_test_benches::paxos_bench::{paxos_bench, Client, Aggregator};
use hydro_test_benches::kv_replica::Replica;

const PAXOS_F: usize = 1; // Maximum number of faulty nodes
const NUM_CLIENTS_PER_NODE: usize = 100;
const CHECKPOINT_FREQUENCY: usize = 1000;

#[cfg(stageleft_runtime)]
#[tokio::main]
async fn main() {
    // Create deployment
    let mut deployment = Deployment::new();
    let localhost = deployment.Localhost();

    // Set up clusters for the different roles
    let builder = hydro_lang::FlowBuilder::new();
    let proposers = builder.cluster::<Proposer>();
    let acceptors = builder.cluster::<Acceptor>();
    let clients = builder.cluster::<Client>();
    let client_aggregator = builder.process::<Aggregator>();
    let replicas = builder.cluster::<Replica>();

    // Run the Paxos benchmark
    paxos_bench(
        NUM_CLIENTS_PER_NODE,
        CHECKPOINT_FREQUENCY,
        PAXOS_F,
        PAXOS_F + 1, // num_replicas
        CorePaxos {
            proposers: proposers.clone(),
            acceptors: acceptors.clone(),
            paxos_config: PaxosConfig {
                f: PAXOS_F,
                i_am_leader_send_timeout: 5,
                i_am_leader_check_timeout: 10,
                i_am_leader_check_timeout_delay_multiplier: 15,
            },
        },
        &clients,
        &client_aggregator,
        &replicas,
    );

    println!("Paxos benchmark example completed");
}

#[cfg(not(stageleft_runtime))]
fn main() {
    println!("This example requires the stageleft_runtime feature to be enabled.");
    println!("Please build with: cargo run --example paxos --features stageleft_runtime");
}
