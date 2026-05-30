import Foundation

final class Trader {

    private let name: String
    private let orderBook: OrderBook

    private var exchangeOpen: Bool

    private var ordersPlaced = 0

    private static let stocks = [
        "RELIANCE",
        "TCS",
        "INFY",
        "HDFC",
        "WIPRO"
    ]

    private static let basePrices = [
        2890.0,
        3520.0,
        1425.0,
        1650.0,
        450.0
    ]

    init(
        name: String,
        orderBook: OrderBook
    ) {

        self.name = name
        self.orderBook = orderBook
        self.exchangeOpen = true
    }

    func stop() {

        exchangeOpen = false
    }

    func start() {

        while exchangeOpen {

            let index =
                Int.random(
                    in: 0..<Self.stocks.count
                )

            let stock =
                Self.stocks[index]

            let basePrice =
                Self.basePrices[index]

            let priceVariation =
                Double.random(
                    in: -0.05...0.05
                )

            let price =
                basePrice *
                (1 + priceVariation)

            let quantity =
                Int.random(in: 1...50)

            let type: OrderType =
                Bool.random()
                ? .buy
                : .sell

            let order = Order(
                orderId:
                    UUID().uuidString,
                traderName: name,
                type: type,
                stock: stock,
                price: price,
                quantity: quantity
            )

            orderBook.addOrder(order)

            print(
                "[\(name)] Submitted: \(order)"
            )

            ordersPlaced += 1

            Thread.sleep(
                forTimeInterval:
                    Double.random(
                        in: 0.05...0.2
                    )
            )
        }
    }

    func summary() -> String {

        "\(name) placed \(ordersPlaced) orders."
    }
}