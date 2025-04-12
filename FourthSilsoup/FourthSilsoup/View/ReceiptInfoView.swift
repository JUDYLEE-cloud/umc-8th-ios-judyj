import SwiftUI

struct ReceiptInfoView: View {
    let receipt: ReceiptsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("주문한 사람: \(receipt.orderer)")
            Text("주문 지점: \(receipt.store)")
            Text("주문한 메뉴: \(receipt.menuItems.joined(separator: ", "))")
            Text("총 가격: \(receipt.totalPrice)원")
            Text("주문 번호: \(receipt.orderNumber)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
