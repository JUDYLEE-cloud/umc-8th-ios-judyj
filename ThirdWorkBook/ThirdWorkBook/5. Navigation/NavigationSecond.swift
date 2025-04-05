import SwiftUI

struct NavigationSecond: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to detail") {
                    path.append("Detail")
                }
            }
            .navigationDestination(for: String.self) { value in
                NavigationSecondDetailView(title: value)
            }
            .navigationTitle("Home")
        }
    }
}

struct NavigationSecondDetailView: View {
    let title: String
    
    var body: some View {
        Text("This is \(title) View")
            .navigationTitle(title)
    }
}

#Preview {
    NavigationSecond()
}
