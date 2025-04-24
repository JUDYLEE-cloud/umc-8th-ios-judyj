import Foundation
import SwiftData

@Model
// 데이터베이스라고 선언

// ReceiptsModel라는 데이터베이스 제작
class ReceiptsModel {
    // @Attribute(.unique) var id: UUID
    
    var store: String // 어느 지점
    var receiptDate: String // 날짜
    var totalPrice: Int // 총가격
    var cratedAt: Date = Date() // 스캔 날짜
    var imageData: Data? // 스캔한 이미지
    
    init (
        store: String,
        receiptDate: String,
        totalPrice: Int,
        cratedAt: Date = Date(),
        imageData: Data? = nil
    ) {
        //self.id = UUID()
        self.store = store
        self.receiptDate = receiptDate
        self.totalPrice = totalPrice
        self.cratedAt = cratedAt
        self.imageData = imageData
    }
}
