// BarcodeScanView와 카메라 화면 위 오버레이 되어 있는 디자인 합치는 뷰
import SwiftUI

struct ISBNScannerView: View {
    let title: String = "바코드를 스캔해주세요"
    let subTitle: String = "ISBN 바코드 스캔을 통해 \n책의 정보를 빠르고 정확하게 가져올 수 있어요."
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var viewModel: ISBNScannerViewModel = .init()
    
    var body: some View {
        ZStack {
            BarcodeScanner { isbn in
                print("isbn", isbn)
                Task {
                    await viewModel.searchBook(isbn: isbn)
                }
            }
            backgroundView()
        }
        .sheet(isPresented: $viewModel.isShowSaveView) {
            SuccessISBNView(viewModel: viewModel)
                .presentationDetents([.fraction(0.7)])
                .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder
    private func backgroundView() -> some View {
        Image(.scanGuide)
            .resizable()
            .overlay(content: {guidelineView()})
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func guidelineView() -> some View {
        VStack {
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subTitle)
                    .lineLimit(2)
                    .lineSpacing(2.5)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(Color.red)
            
            Spacer()
                .frame(height: 450)
            
            Button {
                dismiss()
            } label: {
                Label("나가기", systemImage: "door.right.hand.open")
                    .foregroundStyle(Color.black)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 110.5)
                    .background(Color.white)
                    .cornerRadius(20)
            }
        }

    }
}

#Preview {
    ISBNScannerView()
}
