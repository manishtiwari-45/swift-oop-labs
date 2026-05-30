import Foundation

enum OrderType {
    case buy
    case sell
}

struct Order {

    let orderId: String
    let traderName: String
    let type: OrderType
    let stock: String
    let price: Double
    let quantity: Int
    let timestamp: UInt64

    init(
        orderId: String,
        traderName: String,
        type: OrderType,
        stock: String,
        price: Double,
        quantity: Int
    ) {
        self.orderId = orderId
        self.traderName = traderName
        self.type = type
        self.stock = stock
        self.price = price
        self.quantity = quantity

        self.timestamp =
            DispatchTime.now().uptimeNanoseconds
    }
}

extension Order: CustomStringConvertible {

    var description: String {

        let orderType =
            type == .buy ? "BUY" : "SELL"

        return "\(orderType) \(stock) x\(quantity) @ ₹\(String(format: "%.2f", price)) [\(orderId) by \(traderName)]"
    }
}