// 스캔 성공시 뜨는 책 정보 조회 뷰
import SwiftUI
import Kingfisher

struct SuccessISBNView: View {
    @Bindable var viewModel: ISBNScannerViewModel
    
    var body: some View {
        let thumbnailURLString = viewModel.bookModel?.thumbnail ?? "your-default-image-url"
        
        VStack {
            HStack(spacing: 40) {
                KFImage(URL(string: "\(String(describing: viewModel.bookModel?.thumbnail))"))
                    .placeholder {
                        Image("bookCover")
                            .resizable()
                    }
                    .resizable()
                    .frame(width: 100, height: 150)
                
                bookInfoView()
                
            } // HStack
            
            Button {
                viewModel.purchaseBook()
            } label: {
                Text("구매하기")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 35)
                    .foregroundStyle(Color.black)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color(hex: 0xFFD262))
                    }
            }
            .padding(.top, 20)
    
        } // VStack
    }
    
    private func bookInfoView() -> some View {
        let authorText: String = {
            if let authors  = viewModel.bookModel?.authors, !authors.isEmpty {
                return authors.joined(separator: ", ")
            } else {
                return "저자가 없습니다."
            }
        }()
        
        let priceText: String = {
            if let price = viewModel.bookModel?.price {
                return "\(price)원"
            } else {
                return "가격이 없습니다."
            }
        }()
        
        return VStack(spacing: 16) {
            singleInfoText(title: "도서명", value: "\(viewModel.bookModel?.title ?? "도서명이 없습니다.")")
            singleInfoText(title: "저자", value: authorText)
            singleInfoText(title: "가격", value: priceText)
            singleInfoText(title: "출판사", value: "\(viewModel.bookModel?.publisher ?? "출판사가 없습니다.")")
            singleInfoText(title: "책소개", value: "\(viewModel.bookModel?.contents ?? "책소개가 없습니다.")")
        }
    }
    
    private func singleInfoText(title: String, value: String) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color(hex: 0xF3AD00))
            
            Text(value)
                .font(.caption)
        }
    }
}

#Preview {
    SuccessISBNView(viewModel: .init())
}

extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double((hex >> 0) & 0xFF) / 255
        )
    }
}
