import SwiftUI
import Alamofire

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    static let serviceManager: ServiceManager = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "주디제이")
            }
        }),
        .init(title: "POST", action: {
            Task {
                await serviceManager.postUser(user: .init(name: "하워드", age: 30, address: "포항시 쿨쿨동", height: 180))
            }
        }),
        .init(title: "PATCH", action: {
            Task {
                await serviceManager.patchUser(name: "JudyJ")
            }
        }),
        .init(title: "PUT", action: {
            Task {
                await serviceManager.putUser(user: .init(name: "주디제이", age: 20, address: "경기도 분당구", height: 170))
            }
        }),
        .init(title: "DELETE", action: {
            Task {
                await serviceManager.deleteUser(name: "주디제이")
            }
        }),
        
    ]
}

#Preview {
    ContentView()
}
