import SwiftUI

@main
struct StarbucksCloneTuistApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    init() {
        StarbucksCloneTuistFontFamily.registerAllCustomFonts()
    }
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                CustomTabView()
            } else {
                LoginView()
            }
        }
    }
}
