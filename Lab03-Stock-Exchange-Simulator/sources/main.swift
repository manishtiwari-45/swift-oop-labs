import Foundation

let orderBook =
    OrderBook(capacity: 10)

let buy = Order(
    orderId: "ORD-001",
    traderName: "Alice",
    type: .buy,
    stock: "TCS",
    price: 3520,
    quantity: 15
)

let sell = Order(
    orderId: "ORD-002",
    traderName: "Bob",
    type: .sell,
    stock: "TCS",
    price: 3510,
    quantity: 15
)

orderBook.addOrder(buy)
orderBook.addOrder(sell)

if let match =
    orderBook.takeBestMatch() {

    print(match)
}