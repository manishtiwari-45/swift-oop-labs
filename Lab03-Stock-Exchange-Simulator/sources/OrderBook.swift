import Foundation

final class OrderBook {

    private var buyOrders: [Order] = []
    private var sellOrders: [Order] = []

    private let capacity: Int

    private let condition = NSCondition()

    init(capacity: Int) {
        self.capacity = capacity
    }

    private var totalOrders: Int {
        buyOrders.count + sellOrders.count
    }
    func addOrder(
        _ order: Order
    ) {

        condition.lock()

        defer {
            condition.unlock()
        }

        while totalOrders >= capacity {

            print(
                "[OrderBook] Full. Waiting..."
            )

            condition.wait()
        }

        switch order.type {

        case .buy:
            buyOrders.append(order)

        case .sell:
            sellOrders.append(order)
        }

        condition.signal()
    }

    private func findMatch()
        -> (Int, Int)? {

        for buyIndex in buyOrders.indices {

            let buy =
                buyOrders[buyIndex]

            for sellIndex in sellOrders.indices {

                let sell =
                    sellOrders[sellIndex]

                let sameStock =
                    buy.stock == sell.stock

                let validPrice =
                    buy.price >= sell.price

                if sameStock &&
                validPrice {

                    return (
                        buyIndex,
                        sellIndex
                    )
                }
            }
        }

        return nil
    }

    func takeBestMatch()
        -> MatchedPair? {

        condition.lock()

        defer {
            condition.unlock()
        }

        while true {

            if let (
                buyIndex,
                sellIndex
            ) = findMatch() {

                let buy =
                    buyOrders.remove(
                        at: buyIndex
                    )

                let sell =
                    sellOrders.remove(
                        at: sellIndex
                    )

                condition.signal()

                return MatchedPair(
                    buyOrder: buy,
                    sellOrder: sell
                )
            }

            condition.wait()
        }
    }
}