//import SwiftUI
//import PhotosUI
//
//struct OCRView: View {
//    @Bindable var viewModel: ReceiptsViewModel = .init()
//    @State private var isShowingPicker = false
//    
//    @State private var selectedImage: UIImage? = nil
//    @State private var selectedItems: [PhotosPickerItem] = []
//    
//    @State private var showingActionSheet = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            // 사진 선택 버튼
//            Button(action: {
//                showingActionSheet = true
//            }) {
//                Text("앨범에서 가져오기")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .confirmationDialog("사진 선택", isPresented: $showingActionSheet, titleVisibility: .visible) {
//                Button("앨범에서 가져오기") {
//                    isShowingPicker = true
//                }
//                Button("카메라로 촬영하기") {
//                    // 카메라 촬영 로직 추가 예정
//                }
//                Button("취소", role: .cancel) { }
//            }
//            
//            // 선택한 이미지 보여주기
//            if let selectedImage = selectedImage {
//                Image(uiImage: selectedImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 490)
//            }
//            
//            if let receipt = viewModel.currentReceipt {
//                TemporaryReceiptsView(receipt: receipt)
//            } else {
//                ProgressView("이미지 분석 중...")
//            }
//        }
//        .frame(maxWidth: 337, maxHeight: .infinity)
//        .photosPicker(isPresented: $isShowingPicker, selection: $selectedItems, maxSelectionCount: 1, matching: .images)
//        .onChange(of: selectedItems) { oldItems, newItems in
//            guard let item = newItems.first else { return }
//            Task {
//                if let data = try? await item.loadTransferable(type: Data.self),
//                   let image = UIImage(data: data) {
//                    selectedImage = image
//                    viewModel.startOCR(with: image)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    OCRView()
//}
