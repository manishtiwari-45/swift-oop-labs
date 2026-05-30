import Foundation

let orderBook =
    OrderBook(capacity: 100)

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

let queue =
    DispatchQueue.global()

queue.async {

    trader1.start()
}

queue.async {

    trader2.start()
}

Thread.sleep(
    forTimeInterval: 5
)

trader1.stop()
trader2.stop()

Thread.sleep(
    forTimeInterval: 1
)

print(
    trader1.summary()
)

print(
    trader2.summary()
)

print(
    "Pending Orders:",
    orderBook.getOrderCount()
)