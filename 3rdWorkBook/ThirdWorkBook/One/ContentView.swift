import SwiftUI

struct ContentView: View {
    let viewFruits = [
        Fruit(name: "apple", emoji: "🍎"),
        Fruit(name: "banana", emoji: "🍌"),
        Fruit(name: "cherry", emoji: "🍒"),
        Fruit(name: "grape", emoji: "🍇")
    ]
    var body: some View {
        VStack {
            VStack {
                ForEach(1..<6) {index in
                    Text("항목 \(index)")
                    .font(.headline)}
            }
            
            let fruits = ["apple", "banana", "cherry", "orange", "grape"]
            List {
                ForEach(fruits, id: \.self) {fruits in
                    Text(fruits)
                        .font(.title2)
                }
            }
            
            List {
                ForEach(viewFruits) { fruit in
                    HStack {
                        Text(fruit.emoji)
                        Text(fruit.name)
                            .font(.headline)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
