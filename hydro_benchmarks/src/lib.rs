#[cfg(stageleft_runtime)]
hydro_lang::setup!();

// Re-export types from hydro_test that benchmarks depend on
pub use hydro_test::cluster::{
    kv_replica::Replica as KvReplica,
    paxos::{Acceptor, Proposer},
    paxos_with_client::PaxosLike,
    two_pc::{Coordinator, Participant},
};

pub mod kv_replica;
pub mod paxos_bench;
pub mod two_pc_bench;
