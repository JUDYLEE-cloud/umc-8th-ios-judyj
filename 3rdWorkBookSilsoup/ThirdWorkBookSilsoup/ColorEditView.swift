import SwiftUI

struct ColorEditView: View {
    @Binding var colorItem: ColorItem
    @Binding var selectedColor: ColorItem?
    
    var body: some View {
        VStack {
            Group {
                Text("현재 선택된 색상")
                Text("\(colorItem.name)")
            }
            .font(.system(size: 30))

            Spacer()
            
            Button {
                selectedColor = colorItem
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 2)
                        .background(Color.clear)
                    
                    Text("사과 색 바꾸기")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                }
                .frame(width: 256, height: 122)
            }
        }
        .frame(width: 256, height: 264)
        
    }
}
