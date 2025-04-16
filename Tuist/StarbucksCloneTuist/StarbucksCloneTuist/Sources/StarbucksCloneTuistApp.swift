import SwiftUI
import SwiftData

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
        .modelContainer(for: ReceiptsModel.self)
            
//                    WindowGroup {
//                        ReceiptView(viewModel: ReceiptsViewModel())
//                    }
                    //.modelContainer(for: ReceiptsModel.self)
        }
    }
