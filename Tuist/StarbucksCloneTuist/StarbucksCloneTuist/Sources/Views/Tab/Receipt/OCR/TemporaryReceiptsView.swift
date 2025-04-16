import SwiftUI

struct TemporaryReceiptsView: View {
    let receipt: ReceiptsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("주문 지점: \(receipt.store)")
            Text("주문한 날짜: \(receipt.receiptDate)")
            Text("총 가격: \(receipt.totalPrice)원")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
