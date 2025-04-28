// view
import SwiftUI

struct JSONParsingView: View {
    var viewModel: JSONParsingViewModel = .init()
    @State var showSheet: Bool = false
    
    var body: some View {
        Button {
            viewModel.loadMyProfile { result in
                switch result {
                case .success(_):
                    self.showSheet.toggle()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        } label: {
            Text("Json 파일 파싱하기 버튼")
                .font(.headline)
                .foregroundColor(.red)
        }
        .sheet(isPresented: $showSheet) {
            VStack {
                if let profile = viewModel.myProfile {
                    Text("닉네임: \(profile.nickname)")
                    Text("취미: \(profile.hobby)")
                    Text("좋아하는 캐릭터: \(profile.favoriteCharacter)")
                    Text("거주지: \(profile.location)")
                }
            }
        }

    }
}

#Preview {
    JSONParsingView()
}
