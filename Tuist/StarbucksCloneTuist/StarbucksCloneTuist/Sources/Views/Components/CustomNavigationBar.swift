import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let backAction: () -> Void
    
    var body: some View {
        ZStack {
            Text(title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.mainTextMedium16())
            
            HStack {
                Button(action: backAction) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.leading, 19)
        }
        .ignoresSafeArea()
        .padding(.top, 10)
    }
}
