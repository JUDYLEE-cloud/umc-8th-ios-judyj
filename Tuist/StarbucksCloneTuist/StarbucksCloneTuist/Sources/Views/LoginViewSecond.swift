import SwiftUI

struct LoginViewSecond: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.1) {
                UpperTitle(screenWidth: geometry.size.width)
                LoginTextField(screenWidth: geometry.size.width)
                LoginButton(screenWidth: geometry.size.width)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


private func UpperTitle(screenWidth: CGFloat) -> some View {
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
            .font(.medium(16))
            .foregroundColor(Color("gray01"))
            .padding(.top, 19.0)
    }
    .frame(width: screenWidth * 0.9, alignment: .leading)
}

private func LoginTextField(screenWidth: CGFloat) -> some View {
    VStack {
        CustomTextField(title: "아이디")
        
        CustomTextField(title: "비밀번호")
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("green01"))
                .frame(maxWidth: .infinity, maxHeight: 46)
            
            Text("로그인하기")
                .font(.mainTextMedium16())
                .foregroundColor(.white)
        }
    }
    .font(.mainTextRegular13())
    .foregroundColor(Color("black01"))
    .frame(width: screenWidth * 0.9)
}
private struct CustomTextField: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.mainTextRegular13())
            .foregroundColor(Color("black01"))
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Divider()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color("gray00"))
            .padding(.bottom, 47)
    }
}

private func LoginButton(screenWidth: CGFloat) -> some View {
    VStack(spacing: 19) {
        Text("이메일로 회원가입하기")
            .font(.mainTextRegular12())
            .underline()
            .foregroundColor(Color("gray04"))
        
        SocialLoginButton(title: "카카오 로그인", image: "KakaoLogo", fontcolor: 0x000000, backgroundcolor: 0xFEE500)
        
        SocialLoginButton(title: "Apple로 로그인", image: "AppleLogo", fontcolor: 0xFFFFFF, backgroundcolor: 0x000000)
    }
    .frame(width: screenWidth * 0.69)
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

#Preview {
    LoginViewSecond()
}
