import Foundation
import SwiftData

@Model
// 데이터베이스라고 선언

// ReceiptsModel라는 데이터베이스 제작
class ReceiptsModel {
    @Attribute(.unique) var id: UUID
    
    var orderer: String // 주문자
    var store: String
    var menuItems: [String]
    var totalPrice: Int
    var orderNumber: String
    var cratedAt: Date
    
    init (
        orderer: String,
        store: String,
        menuItems: [String],
        totalPrice: Int,
        orderNumber: String,
        cratedAt: Date = Date()
    ) {
        self.id = UUID()
        self.orderer = orderer
        self.store = store
        self.menuItems = menuItems
        self.totalPrice = totalPrice
        self.orderNumber = orderNumber
        self.cratedAt = cratedAt
    }
}
