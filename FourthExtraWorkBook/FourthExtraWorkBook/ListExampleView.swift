import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let color: ColorCategory
}

enum ColorCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case red = "Red"
    case yellow = "Yellow"
    case green = "Green"
    
    var id: String { self.rawValue }
}

struct Token: Identifiable, Hashable {
    let id = UUID()
    let keyword: String
}

struct SearchScopeTokenExampleView: View {
    @State private var searchText = ""
    @State private var tokens: [Token] = []
    @State private var selectedScope: ColorCategory = .all
    
    let fruits: [Fruit] = [
        Fruit(name: "Apple", color: .red),
        Fruit(name: "Strawberry", color: .red),
        Fruit(name: "Banana", color: .yellow),
        Fruit(name: "Mango", color: .yellow),
        Fruit(name: "Kiwi", color: .green)
    ]
    
    // 🔍 검색 필터
    var filteredFruits: [Fruit] {
        fruits.filter { fruit in
            let matchesScope = selectedScope == .all || fruit.color == selectedScope
            let matchesTokens = tokens.isEmpty || tokens.allSatisfy { fruit.name.localizedCaseInsensitiveContains($0.keyword) }
            return matchesScope && matchesTokens
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredFruits) { fruit in
                    Text("\(fruit.name) 🍎")
                }
            }
            .navigationTitle("Fruits")
            .searchable(text: $searchText, tokens: $tokens, token: \.keyword) {
                // 🔎 검색 제안
                ForEach(fruits.map(\.name).filter { $0.hasPrefix(searchText) }, id: \.self) { suggestion in
                    Text("🔍 \(suggestion)").searchCompletion(suggestion)
                }
            }
            .searchScopes($selectedScope) {
                ForEach(ColorCategory.allCases) { scope in
                    Text(scope.rawValue).tag(scope)
                }
            }
        }
    }
}

#Preview {
    SearchScopeTokenExampleView()
}
