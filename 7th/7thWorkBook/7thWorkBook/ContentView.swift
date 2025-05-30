import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) {
                button in
                Button {
                    button.action()
                } label: {
                    Text(button.title)
                }

            }
        }
        .padding()
    }
    
    struct ButtonInfo: Identifiable {
        var id: UUID = .init()
        var title: String
        var action: () -> Void
    }
    
    final class ButtonInfoList {
        static let serviceManager: ContentViewModel = .init()
        
        static let buttonList: [ButtonInfo] = [
            .init(title: "GET", action: {
                serviceManager.getUserData(name: "주디제이")
            }),
            .init(title: "POST", action: {
                serviceManager.createUser(.init(name: "주디제이", age: 30, address: "서울 서대문구", height: 180))
            }),
            .init(title: "PATCH", action: {
                serviceManager.updateUserPatch(.init(name: nil, age: 20, address: "경기도 성남시", height: 165))
            }),
            .init(title: "DELETE", action: {
                serviceManager.deleteUser(name: "주디제이")
            })
        ]
    }
}

#Preview {
    ContentView()
}
