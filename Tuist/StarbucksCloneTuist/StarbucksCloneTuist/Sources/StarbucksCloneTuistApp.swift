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
            //CustomTabView()
            
//            if isLoggedIn {
//                CustomTabView()
//            } else {
//                LoginView()
//            }
            
            StoreInformationView()
        }
        .modelContainer(for: ReceiptsModel.self)
    }
}


extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double((hex >> 0) & 0xFF) / 255
        )
    }
}
