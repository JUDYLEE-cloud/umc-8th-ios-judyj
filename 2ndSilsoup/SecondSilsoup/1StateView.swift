import SwiftUI

struct StateView: View {
    
    @State private var count = 0
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text("how many times you clicked? : \(count)")
                .font(.largeTitle)
            
            Button(action: {
                count += 1
            }) {
                Text("Click me!")
            }
            .padding()
            
            Text("type anything!: \(text)")
                .font(.largeTitle)
            TextField("Type anything...", text: $text)
                .padding()
        }
    }
}

//#Preview {
//    StateView()
//}

struct StateView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            StateView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
 
