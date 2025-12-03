// Example demonstrating how to run the Compartmentalized Paxos benchmark
//
// This example shows how to set up and execute the compartmentalized Paxos consensus
// protocol benchmark. This variant uses a grid-based architecture for acceptors to
// improve scalability.

use hydro_deploy::Deployment;
use hydro_lang::deploy::{DeployCrateWrapper, HydroDeploy, TrybuildHost};
use hydro_test_benches::paxos::{PaxosConfig, Proposer, Acceptor};
use hydro_test_benches::compartmentalized_paxos::{
    CoreCompartmentalizedPaxos, CompartmentalizedPaxosConfig, ProxyLeader,
};
use hydro_test_benches::paxos_bench::{paxos_bench, Client, Aggregator};
use hydro_test_benches::kv_replica::Replica;

const PAXOS_F: usize = 1; // Maximum number of faulty nodes
const NUM_CLIENTS_PER_NODE: usize = 100;
const CHECKPOINT_FREQUENCY: usize = 1000;
const NUM_PROXY_LEADERS: usize = 2;
const ACCEPTOR_GRID_ROWS: usize = 2;
const ACCEPTOR_GRID_COLS: usize = 2;

#[cfg(stageleft_runtime)]
#[tokio::main]
async fn main() {
    // Create deployment
    let mut deployment = Deployment::new();
    let localhost = deployment.Localhost();

    // Set up clusters for the different roles
    let builder = hydro_lang::FlowBuilder::new();
    let proposers = builder.cluster::<Proposer>();
    let proxy_leaders = builder.cluster::<ProxyLeader>();
    let acceptors = builder.cluster::<Acceptor>();
    let clients = builder.cluster::<Client>();
    let client_aggregator = builder.process::<Aggregator>();
    let replicas = builder.cluster::<Replica>();

    // Run the Compartmentalized Paxos benchmark
    paxos_bench(
        NUM_CLIENTS_PER_NODE,
        CHECKPOINT_FREQUENCY,
        PAXOS_F,
        PAXOS_F + 1, // num_replicas
        CoreCompartmentalizedPaxos {
            proposers: proposers.clone(),
            proxy_leaders: proxy_leaders.clone(),
            acceptors: acceptors.clone(),
            config: CompartmentalizedPaxosConfig {
                paxos_config: PaxosConfig {
                    f: PAXOS_F,
                    i_am_leader_send_timeout: 5,
                    i_am_leader_check_timeout: 10,
                    i_am_leader_check_timeout_delay_multiplier: 15,
                },
                num_proxy_leaders: NUM_PROXY_LEADERS,
                acceptor_grid_rows: ACCEPTOR_GRID_ROWS,
                acceptor_grid_cols: ACCEPTOR_GRID_COLS,
                num_replicas: PAXOS_F + 1,
                acceptor_retry_timeout: 1000,
            },
        },
        &clients,
        &client_aggregator,
        &replicas,
    );

    println!("Compartmentalized Paxos benchmark example completed");
}

#[cfg(not(stageleft_runtime))]
fn main() {
    println!("This example requires the stageleft_runtime feature to be enabled.");
    println!("Please build with: cargo run --example compartmentalized_paxos --features stageleft_runtime");
}
