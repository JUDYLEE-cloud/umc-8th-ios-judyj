import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color("green01")
                .ignoresSafeArea()
            
            Image("StarbucksLogo")
                .resizable()
                .frame(width: 168, height: 168)
        }
    }
}

#Preview {
    SplashView()
}

