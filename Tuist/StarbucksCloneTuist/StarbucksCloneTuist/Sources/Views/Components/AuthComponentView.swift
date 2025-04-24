import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var viewmodeltext: String
    
    @FocusState var isFocused: Bool
    @State private var isPasswordVisible: Bool = false
    
    var isMatching: Bool = true

    var body: some View {
        VStack {
            VStack {
                HStack {
                    if title == "비밀번호" || title == "비밀번호 확인" {
                        if isPasswordVisible {
                            TextField(title, text: $viewmodeltext)
                                .focused($isFocused)
                                .font(.mainTextRegular13())
                                .foregroundColor(Color("black01"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textFieldStyle(.plain)
                        } else {
                            SecureField(title, text: $viewmodeltext)
                                .focused($isFocused)
                                .font(.mainTextRegular13())
                                .foregroundColor(Color("black01"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textFieldStyle(.plain)
                        }
                    } else {
                        TextField(title, text: $viewmodeltext)
                            .focused($isFocused)
                            .font(.mainTextRegular13())
                            .foregroundColor(Color("black01"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textFieldStyle(.plain)
                    }
                    
                    if title == "비밀번호" || title == "비밀번호 확인" {
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .resizable()
                                .frame(width: 24, height: 18)
                                .foregroundColor(Color("gray04"))
                                .padding(.bottom, 5)
                                .padding(.trailing, 5)
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 0.7)
                    .padding(.top, -5)
                    .foregroundColor(title == "비밀번호 확인" && !isMatching ? Color.red : (isFocused ? Color("green01") : Color("gray01")))
                }
            .frame(height: 20.02)
            
            if title == "비밀번호 확인" && !isMatching {
                Text("일치하지 않습니다")
                    .foregroundColor(.red)
                    .font(.mainTextRegular12())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            
            }
        }
        .padding(.bottom, 47)
        }
}

struct GreenButton: View {
    let title: String
    var isDisabled: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("green01"))
                .frame(maxWidth: .infinity, maxHeight: 46)
                .opacity(isDisabled ? 0.3 : 1.0)
            
            Text(title)
                .font(.mainTextMedium16())
                .foregroundColor(.white)
        }
    }
}
