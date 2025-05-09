import SwiftUI

struct ColorItem: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

struct ContentView: View {
    @State private var colors: [ColorItem] = [
        ColorItem(name: "빨강", color: .red),
        ColorItem(name: "주황", color: .orange),
        ColorItem(name: "노랑", color: .yellow),
        ColorItem(name: "초록", color: .green),
        ColorItem(name: "파랑", color: .blue),
        ColorItem(name: "보라", color: .purple),
        ColorItem(name: "핑크", color: .pink)
    ]
    @State private var selectedColor: ColorItem?
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach($colors) { $color in
                        NavigationLink(destination: ColorEditView(colorItem: $color, selectedColor: $selectedColor)) {
                            VStack {
                                Rectangle()
                                    .fill(color.color)
                                    .frame(width: 87, height: 87)
                                
                                Text(color.name)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Image(systemName: "apple.logo")
                    .resizable()
                    .frame(width: 200, height: 250)
                    .foregroundColor(selectedColor?.color ?? .black)

                Spacer()
                
                Text("현재 선택된 색상: \(selectedColor?.name ?? "없음")")
            }
        }
    }
}

#Preview {
    ContentView()
}
