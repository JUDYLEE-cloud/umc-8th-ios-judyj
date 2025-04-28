import SwiftUI

struct StoreSelectModalView: View {
    var viewModel = JSONParsingViewModel()
    
    var body: some View {
        VStack {
            UpperBar()
            
            ScrollView {
                if let mapInfo = viewModel.mapInfo {
                    ForEach(mapInfo.features) { feature in
                        VStack {
                            Text(feature.properties.storeName)
                            Text(feature.properties.address)
                        }
                    }
                } else {
                    Text("로딩 중...")
                }
            }
        }
        .padding(.horizontal, 32.5)
        .onAppear {
            viewModel.loadMapInfo{ result in
                switch result {
                case .success(_): break
                case .failure(_): print("json 파일 로드 실패")
                }
            }
        }
    }
}

struct UpperBar: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 4)
                .foregroundColor(Color("gray04"))
            
            ZStack {
                Text("매장 설정")
                    .font(.system(size: 16))
                HStack {
                    Spacer()
                    Image(systemName: "map")
                        .foregroundColor(Color("gray04"))
                }
            }
            .padding(.vertical, 24)
        }
    }
}

#Preview {
    StoreSelectModalView()
}
