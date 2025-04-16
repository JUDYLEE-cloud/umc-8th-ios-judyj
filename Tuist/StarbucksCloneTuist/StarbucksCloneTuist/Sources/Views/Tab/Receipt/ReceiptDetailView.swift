import SwiftUI
import PhotosUI

struct ReceiptDetailView: View {
    @Environment(\.dismiss) var dismiss
    let receipt: ReceiptsModel
    // let image: UIImage?
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            ZStack {
                if let data = receipt.imageData,
                   let uiImage = UIImage(data: data)
                {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 600)
                        .overlay(
                            HStack {
                                Spacer()
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.gray)
                                        .frame(width: 18, height: 18)
                                        .padding()
                                }
                            },
                            alignment: .topTrailing
                        )
                }
            }
            .frame(height: 600)
        }
    }
}

#Preview {
    ReceiptDetailView(
        receipt: ReceiptsModel(store: "스타벅스", receiptDate: "2024-04-13", totalPrice: 6500, imageData: UIImage(named: "FirstReceipt")?.jpegData(compressionQuality: 0.8))
    )
}
