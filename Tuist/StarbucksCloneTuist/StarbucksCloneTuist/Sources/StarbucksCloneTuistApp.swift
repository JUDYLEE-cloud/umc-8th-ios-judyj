import SwiftUI
import SwiftData
import KakaoSDKCommon

@main
struct StarbucksCloneTuistApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    init() {
        StarbucksCloneTuistFontFamily.registerAllCustomFonts()
        KakaoSDK.initSDK(appKey: "5e47de3dd52ca27f6de5f544c1ca9947")
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                CustomTabView()
            } else {
                LoginView()
            }
        }
        .modelContainer(for: ReceiptsModel.self)
    }
}
