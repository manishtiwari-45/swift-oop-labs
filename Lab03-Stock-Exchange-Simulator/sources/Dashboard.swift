Dashboard.swiftimport Foundation

final class Dashboard {

    private let stats: ExchangeStats

    private let orderBook: OrderBook

    private var timer:
        DispatchSourceTimer?

    init(
        stats: ExchangeStats,
        orderBook: OrderBook
    ) {

        self.stats = stats
        self.orderBook = orderBook
    }

    func start() {

        let timer =
            DispatchSource.makeTimerSource()

        timer.schedule(
            deadline: .now(),
            repeating: 2
        )

        timer.setEventHandler {

            print()

            print(
                "===== EXCHANGE DASHBOARD ====="
            )

            print(
                self.stats.getSnapshot()
            )

            print(
                "Pending Orders: \(self.orderBook.getOrderCount())"
            )

            print(
                "=============================="
            )

            print()
        }

        timer.resume()

        self.timer = timer
    }

    func stop() {

        timer?.cancel()
        timer = nil
    }
}