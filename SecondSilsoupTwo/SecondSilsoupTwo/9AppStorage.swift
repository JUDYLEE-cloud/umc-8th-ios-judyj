import SwiftUI

struct __1AppStorage: View {
    
    @AppStorage("usernickname") private var usernickname: String = "JudyJ"
    @AppStorage("userAge") private var userage: Int = 20
    @AppStorage("isDarkmode") private var isDarkmode: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, \(usernickname)")
            Button("Change nickname") {
                usernickname = "Apple"
            }
            Divider()
            Text("Age: \(userage)")
            Button("After one year..") {
                userage += 1
            }
            Divider()
            Toggle(isOn: $isDarkmode) {
                Text("is it dark mode now?")
            }
        }
    }
}

#Preview {
    __1AppStorage()
}
