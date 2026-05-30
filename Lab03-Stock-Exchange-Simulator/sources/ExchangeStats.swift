import Foundation

final class ExchangeStats {

    private let lock = NSLock()

    private var totalTrades = 0
    private var totalVolume = 0

    private var lastTradePrice = 0.0
    private var highestPrice = 0.0
    private var lowestPrice = Double.greatestFiniteMagnitude

    func recordTrade(
        price: Double,
        quantity: Int
    ) {

        lock.lock()

        defer {
            lock.unlock()
        }

        totalTrades += 1
        totalVolume += quantity

        lastTradePrice = price

        highestPrice =
            max(highestPrice, price)

        lowestPrice =
            min(lowestPrice, price)
    }

    func getSnapshot() -> String {

        lock.lock()

        defer {
            lock.unlock()
        }

        let low =
            lowestPrice ==
            Double.greatestFiniteMagnitude
            ? 0
            : lowestPrice

        return """
        Trades: \(totalTrades) | Volume: \(totalVolume) | Last: \(String(format: "%.2f", lastTradePrice)) | High: \(String(format: "%.2f", highestPrice)) | Low: \(String(format: "%.2f", low))
        """
    }

    func getTotalTrades() -> Int {

        lock.lock()

        defer {
            lock.unlock()
        }

        return totalTrades
    }

    func getTotalVolume() -> Int {

        lock.lock()

        defer {
            lock.unlock()
        }

        return totalVolume
    }
}