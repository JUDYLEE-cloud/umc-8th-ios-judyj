import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let backAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Spacer()
                
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
                Spacer()
                    .frame(height: 22)
            }
        }
        .ignoresSafeArea()
        .frame(height: 100)
        .padding(.top, 10)
    }
}
