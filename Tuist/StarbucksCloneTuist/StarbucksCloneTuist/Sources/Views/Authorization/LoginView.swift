import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
                UpperTitle
                Spacer()
                LoginTextField
                Spacer()
                SocialLogin()
            }
        .safeAreaPadding(.top, 104)
        .padding(.horizontal, 14)        //safeareapadding으로 줘보기
    }
    
    private var UpperTitle: some View {
        HStack {
            VStack(alignment: .leading) {
                Image("StarbucksLogo")
                    .resizable()
                    .frame(width: 97, height: 95)
                    .padding(.bottom, 28.0)
                
                Group {
                    Text("안녕하세요.")
                    Text("스타벅스입니다.")
                }
                .font(.mainTextBold24())
                
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .font(.mainTextMedium16())
                    .kerning(-1)
                    .foregroundColor(Color("gray01"))
                    .padding(.top, 19)
            }
            Spacer()
        }
        .frame(height: 219, alignment: .topLeading)
    }
    
    @StateObject private var viewModel = LoginViewModel()
    private var LoginTextField: some View {
        VStack {
            CustomTextField(title: "아이디", viewmodeltext: $viewModel.loginModel.id)
            CustomTextField(title: "비밀번호", viewmodeltext: $viewModel.loginModel.password)
            Button {
                viewModel.loginModel.login()
            } label: {
                GreenButton(title: "로그인하기")
            }
        }
        .frame(alignment: .leading)
    }
    // 공용 컴포넌트는 - 재사용성 때문에 동적으로 설정.
    
    private struct SocialLogin: View {
        var body: some View {
            VStack(spacing: 19) {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular12())
                    .underline()
                    .foregroundColor(Color("gray04"))
                
                SocialLoginButton(title: "카카오 로그인", image: "KakaoLogo", fontcolor: 0x000000, backgroundcolor: 0xFEE500)
                
                SocialLoginButton(title: "Apple로 로그인", image: "AppleLogo", fontcolor: 0xFFFFFF, backgroundcolor: 0x000000)
            }
            .frame(width: 306, height: 144)
        }
    }
    private struct SocialLoginButton: View {
        let title: String
        let image: String
        let fontcolor: Int
        let backgroundcolor: Int
        
        var body: some View {
            HStack {
                Image(image)
                    .padding(.leading, 14.0)
                Spacer()
                Text(title)
                    .padding(.trailing, 14.0)
                    .foregroundColor(Color(hex: fontcolor))
                    .font(.mainTextMedium16())
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(Color(hex: backgroundcolor))
            .cornerRadius(6)
        }
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

//#Preview {
//    LoginViewSecond()
//}

struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
