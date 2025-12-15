// Arrange benchmark using differential dataflow
// This benchmark tests the performance of arrange operations

use timely::dataflow::operators::ToStream;
use differential_dataflow::operators::arrange::ArrangeBySelf;
use differential_dataflow::operators::Count;

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            (0..100_000u32)
                .to_stream(scope)
                .map(|x| (x, ()))
                .as_collection()
                .arrange_by_self()
                .count()
                .inspect(move |x| {
                    if index == 0 && x.0 % 10_000 == 0 {
                        println!("Worker {}/{} arranged: {:?}", index, peers, x);
                    }
                });
        });
        
        println!("Arrange benchmark completed on worker {}/{}", index, peers);
    }).expect("Differential computation failed");
}
