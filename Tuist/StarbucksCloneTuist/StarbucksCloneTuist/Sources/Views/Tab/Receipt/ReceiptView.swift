import SwiftUI
import PhotosUI
import SwiftData

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \ReceiptsModel.cratedAt, order: .reverse) var receipts: [ReceiptsModel]
    
    @State private var showActionSheet = false
    @State private var isShowingPicker = false
    
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedRecipt: ReceiptsModel? = nil
    @Bindable var viewModel: ReceiptsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("white01")
                    .ignoresSafeArea()
                
                VStack {
                    ReceiptUpperBarView(dismiss: dismiss, showActionSheet: $showActionSheet, isShowingPicker: $isShowingPicker)
                        .ignoresSafeArea()
                        .padding(.bottom, -60)
                    
                    VStack {
                        HStack {
                            Text("총 \(receipts.count)건")
                            Spacer()
                            Text("사용합계 \(receipts.reduce(0) { $0 + $1.totalPrice })")
                        }
                        .padding(.top, 16)
                        
                        List {
                            ForEach(receipts, id: \.self) { receipt in
                                ReceiptHistory(receipt: receipt, selectedReceipt: $selectedRecipt)
                                    .padding(.bottom, 8)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets())
                                    .scrollContentBackground(.hidden)
                                    .background(Color("white01"))
                            }
                        }
                        .listStyle(.plain)
                    }
                    .padding(.horizontal, 19)
                    
                    Spacer()
                }
            }
            .photosPicker(isPresented: $isShowingPicker, selection: $selectedItems, maxSelectionCount: 1, matching: .images)
            .onChange(of: selectedItems) { oldItems, newItems in
                guard let item = newItems.first else { return }
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                        viewModel.startOCR(with: image)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            if let parsed = viewModel.currentReceipts.last {
                                context.insert(parsed)
                            }
                        }
                    }
                }
            }
            .fullScreenCover(item: $selectedRecipt) { selected in
                ReceiptDetailView(receipt: selected)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ReceiptHistory: View {
    let receipt: ReceiptsModel
    @Binding var selectedReceipt: ReceiptsModel?
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(receipt.store)
                        .font(.mainTextSemiBold18())
                    Text(receipt.receiptDate)
                        .font(.mainTextMedium16())
                        .foregroundColor(Color("gray03"))
                    Text("\(receipt.totalPrice)")
                        .font(.mainTextSemiBold18())
                        .foregroundColor(Color("brown02"))
                }
                
                Spacer()
            
                Button {
                    selectedReceipt = receipt
                } label: {
                    Image("receiptLogo")
                }
            }
            Divider()
                .foregroundColor(Color("gray01"))
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                deleteReceipt()
            } label: {
                Label("삭제", systemImage: "trash")
            }
            .tint(.red)
        }
    }
    
    private func deleteReceipt() {
        context.delete(receipt)
    }
}

//private struct ReceiptHistory: View {
//    let receipt: ReceiptsModel
//    @Binding var selectedReceipt: ReceiptsModel?
//    
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(receipt.store)
//                        .font(.mainTextSemiBold18())
//                    Text(receipt.receiptDate)
//                        .font(.mainTextMedium16())
//                        .foregroundColor(Color("gray03"))
//                    Text("\(receipt.totalPrice)")
//                        .font(.mainTextSemiBold18())
//                        .foregroundColor(Color("brown02"))
//                }
//                
//                Spacer()
//            
//                Button {
//                    selectedReceipt = receipt
//                } label: {
//                    Image("receiptLogo")
//                }
//            }
//            Divider()
//                .foregroundColor(Color("gray01"))
//        }
//    }
//}

#Preview {
    ReceiptView(viewModel: ReceiptsViewModel())
}
