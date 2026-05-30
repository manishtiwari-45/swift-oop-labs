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

let traders = [

    Trader(
        name: "Trader-1",
        orderBook: orderBook
    ),

    Trader(
        name: "Trader-2",
        orderBook: orderBook
    ),

    Trader(
        name: "Trader-3",
        orderBook: orderBook
    ),

    Trader(
        name: "Trader-4",
        orderBook: orderBook
    ),

    Trader(
        name: "Trader-5",
        orderBook: orderBook
    )
]

let engine =
    MatchingEngine(
        orderBook: orderBook,
        stats: stats
    )

dashboard.start()

print()
print("===== STOCK EXCHANGE OPEN =====")
print()

let traderTasks =
    traders.map { trader in

        Task {

            trader.run()
        }
    }

let engineTask = Task {

    engine.run()
}

Thread.sleep(
    forTimeInterval: 15
)

print()
print("===== CLOSING EXCHANGE =====")
print()

for trader in traders {

    trader.stop()
}

engine.stop()

orderBook.wakeAll()

print()
print("Collecting results...")
print()

for task in traderTasks {

    do {

        let result =
            try await task.value

        print(result)

    } catch {

        print(
            "Trader task failed"
        )
    }
}

do {

    let result =
        try await engineTask.value

    print(result)

} catch {

    print(
        "Engine task failed"
    )
}

dashboard.stop()

print()

print(
    "===== FINAL SUMMARY ====="
)

print(
    stats.getSnapshot()
)

print(
    "Pending Orders: \(orderBook.getOrderCount())"
)

print()

print(
    "All components shut down successfully."
)