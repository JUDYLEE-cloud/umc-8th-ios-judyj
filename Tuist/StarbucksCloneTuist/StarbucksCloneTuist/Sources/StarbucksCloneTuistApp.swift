import SwiftUI

@main
struct StarbucksCloneTuistApp: App {
    init() {
        StarbucksCloneTuistFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
