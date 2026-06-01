import Foundation

struct MatchedPair {

    let buyOrder: Order
    let sellOrder: Order

    let executionPrice: Double
    let executedQuantity: Int

    init(
        buyOrder: Order,
        sellOrder: Order
    ) {

        self.buyOrder = buyOrder
        self.sellOrder = sellOrder

        self.executionPrice =
            (buyOrder.price + sellOrder.price)
            / 2.0

        self.executedQuantity =
            min(
                buyOrder.quantity,
                sellOrder.quantity
            )
    }
}

extension MatchedPair:
    CustomStringConvertible {

    var description: String {

        return """
        BUY \(buyOrder.stock) @\(String(format: "%.2f", buyOrder.price)) x\(executedQuantity) <-> SELL \(sellOrder.stock) @\(String(format: "%.2f", sellOrder.price)) x\(executedQuantity) => Executed @\(String(format: "%.2f", executionPrice)) x\(executedQuantity)
        """
    }
}