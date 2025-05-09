import SwiftUI

//LazyStack은 항상 scrollview와 함께 사용
struct First: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 50) {
                ForEach(1...50, id: \.self) { index in
                    Text("item: \(index)")
                        .background(Color.green.opacity(0.2))
                        .frame(width: 100, height: 30)
                }
            }
        }
        
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 15, content: {
                ForEach(1...50, id: \.self) { index in
                    Text("아이템: \(index)")
                        .background(Color.green)
                        .frame(width: 100, height: 100)
                }
            })
        })
        
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(1...10, id: \.self) {rowIndex in
                    VStack(alignment: .leading) {
                        Text("section \(rowIndex)")
                            .font(.headline)
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(1...10, id: \.self) {columnIndex in
                                    Text("item: \(columnIndex)")
                                        .frame(width: 50, height: 50)
                                        .background(Color.blue.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    First()
}
