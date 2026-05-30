import Foundation

let orderBook =
    OrderBook(capacity: 100)

let stats =
    ExchangeStats()

let dashboard =
    Dashboard(
        stats: stats,
        orderBook: orderBook
    )

let trader1 =
    Trader(
        name: "Trader-1",
        orderBook: orderBook
    )

let trader2 =
    Trader(
        name: "Trader-2",
        orderBook: orderBook
    )

let engine =
    MatchingEngine(
        orderBook: orderBook,
        stats: stats
    )

dashboard.start()

DispatchQueue.global().async {

    trader1.start()
}

DispatchQueue.global().async {

    trader2.start()
}

DispatchQueue.global().async {

    engine.start()
}

Thread.sleep(
    forTimeInterval: 8
)

trader1.stop()
trader2.stop()

engine.stop()

orderBook.wakeAll()

Thread.sleep(
    forTimeInterval: 2
)

dashboard.stop()

print()

print("FINAL STATS")

print(
    stats.getSnapshot()
)

print(
    trader1.summary()
)

print(
    trader2.summary()
)

print(
    engine.summary()
)