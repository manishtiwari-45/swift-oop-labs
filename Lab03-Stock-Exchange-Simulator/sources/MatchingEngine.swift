import Foundation

final class MatchingEngine {

    private let orderBook: OrderBook

    private let stats: ExchangeStats

    private var exchangeOpen: Bool

    private var matchedTrades = 0

    init(
        orderBook: OrderBook,
        stats: ExchangeStats
    ) {

        self.orderBook = orderBook
        self.stats = stats
        self.exchangeOpen = true
    }

    func stop() {

        exchangeOpen = false
    }

    func start() {

        print("[Engine] Started")

        while true {

            guard let match =
                orderBook.takeBestMatch(
                    exchangeOpen: {
                        self.exchangeOpen
                    }
                )
            else {

                break
            }

            stats.recordTrade(
                price:
                    match.executionPrice,
                quantity:
                    match.executedQuantity
            )

            print(
                "[Engine] MATCHED: \(match)"
            )

            matchedTrades += 1
        }

        print("[Engine] Stopped")
    }

    func summary() -> String {

        "Engine executed \(matchedTrades) trades."
    }
}