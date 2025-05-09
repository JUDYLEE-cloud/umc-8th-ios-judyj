import SwiftUI

struct NavigationFrist: View {
    let items = ["judyj", "ivy", "minbol", "ian", "velko"]
    
    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                NavigationLink {
                    DetailView(item: item)
                } label: {
                    Text(item)
                }

            }
            .navigationTitle("Study Name")
        }
    }
}

struct DetailView: View {
    let item: String
    var body: some View {
        Text("selected: \(item)")
            .font(.largeTitle)
            .navigationTitle(item)
    }
}

#Preview {
    NavigationFrist()
}
