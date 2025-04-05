import SwiftUI

struct FirstView: View {
    let rows = Array(repeating: GridItem(.fixed(80)), count: 3)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) {index in
                    Text("Item \(index)")
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                }
            }
        }
        .scrollIndicators(.visible, axes: .vertical)
        .contentMargins(.horizontal, 100, for: .scrollIndicators)
    }
}

#Preview {
    FirstView()
}
