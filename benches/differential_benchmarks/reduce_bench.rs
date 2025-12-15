// Reduce benchmark using differential dataflow
// This benchmark tests the performance of reduce operations

use timely::dataflow::operators::ToStream;
use differential_dataflow::operators::Reduce;

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            (0..50_000u32)
                .to_stream(scope)
                .map(|x| ((x % 100, x), ()))
                .as_collection()
                .reduce(|_key, input, output| {
                    let sum: u32 = input.iter().map(|(val, _)| val).sum();
                    output.push((sum, 1));
                })
                .inspect(move |x| {
                    if index == 0 && x.0.0 % 10 == 0 {
                        println!("Worker {}/{} reduced: {:?}", index, peers, x);
                    }
                });
        });
        
        println!("Reduce benchmark completed on worker {}/{}", index, peers);
    }).expect("Differential computation failed");
}
