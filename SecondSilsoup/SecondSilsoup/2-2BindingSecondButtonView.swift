import SwiftUI

struct BindingSecondButtonView: View {
    
//    @Binding var isClosed: Bool
//    init(isClosed: Binding<Bool>) {
//        self._isClosed = isClosed
//    }
    
//    @Binding var count: Int
//    init(count: Binding<Int>) {
//        self._count = count
//    }
    
    @Binding var usertext: String
    init(usertext: Binding<String>) {
        self._usertext = usertext
    }
    
    var body: some View {
//        Button {
//            isClosed.toggle()
//            print("하위 뷰에서 클릭해서 값 변경: \(isClosed)")
//        } label: {
//            Text("상위 뷰의 state 값 변경")
//        }
      
//        Button {
//            count += 1
//        } label: {
//            Text("상위 뷰의 count 수 증가")
//        }
        
        Button {
            print("입력한 값: \(usertext)")
        } label: {
            TextField("usertext", text: $usertext)
        }


    }
}
