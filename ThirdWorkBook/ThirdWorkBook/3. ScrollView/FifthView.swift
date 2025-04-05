import SwiftUI

struct FifthView: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Offset: \(Int(scrollOffset))")
                .font(.headline)
            
            ScrollView {
                LazyVStack {
                    ForEach(0..<50, id: \.self) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.3))
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                scrollOffset = proxy.frame(in: .global).minY
                            }
                            .onChange(of: proxy.frame(in: .global).minY) { oldValue, newValue in
                                scrollOffset = newValue
                            }
                    }
                )
            }
        }
    }
}

#Preview {
    FifthView()
}
