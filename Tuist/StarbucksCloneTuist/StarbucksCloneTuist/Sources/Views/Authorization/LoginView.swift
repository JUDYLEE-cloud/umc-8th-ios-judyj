import SwiftUI
import Observation

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    @State var router = NavigationRouter()
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Spacer()
                UpperTitle()
                Spacer()
                LoginTextField()
                Spacer()
                SocialLogin(router: router)
                Spacer()
            }
            // .safeAreaPadding(.top, 104)
            .padding(.horizontal, 14) //safeareapadding으로 줘보기
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup: SignupView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func UpperTitle() -> some View {
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
    
    @ViewBuilder
    private func LoginTextField() -> some View {
        VStack {
            CustomTextField(title: "아이디", viewmodeltext: $viewModel.inputID)
            CustomTextField(title: "비밀번호", viewmodeltext: $viewModel.inputPassword)
            Button {
                viewModel.login()
            } label: {
                GreenButton(title: "로그인하기")
            }
        }
        .frame(alignment: .leading)
    }
    // 공용 컴포넌트는 - 재사용성 때문에 동적으로 설정.
    
    // 카톡 로그인 버젼 1: rest api + alamofire
    private struct SocialLogin: View {
        let router: NavigationRouter
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

        var body: some View {
            VStack(spacing: 19) {
                Button {
                    router.push(.signup)
                } label: {
                    Text("이메일로 회원가입하기")
                        .font(.mainTextRegular12())
                        .underline()
                        .foregroundColor(Color("gray04"))
                }
                
                Button {
                    // 1) access 토큰 요청 (POST /oauth/token)
                    // 그런데 redirect url 설정을 못해서 실패..
                    requestKakaoAuthCode()
                } label: {
                    SocialLoginButton(title: "카카오 로그인", image: "KakaoLogo", fontcolor: 0x000000, backgroundcolor: 0xFEE500)
                }
                .onOpenURL { url in
                    // 2) 인가 코드 받아옴
                    getKakaoAuthCode(url) { code in
                        // 3) 받은 인가 코드로 토큰 요청
                        requestKakaoToken(authCode: code)
                    }
                }
                
                SocialLoginButton(title: "Apple로 로그인", image: "AppleLogo", fontcolor: 0xFFFFFF, backgroundcolor: 0x000000)
            }
            .frame(width: 306, height: 144)
        }
    }
    
    // 카톡 로그인 버젼2: sdk
//    private struct SocialLogin: View {
//        let router: NavigationRouter
//        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
//        
//        var body: some View {
//            VStack(spacing: 19) {
//                Button {
//                    router.push(.signup)
//                } label: {
//                    Text("이메일로 회원가입하기")
//                        .font(.mainTextRegular12())
//                        .underline()
//                        .foregroundColor(Color("gray04"))
//                }
//                
//                Button {
//                    // 카카오 앱이 있는 경우
//                    if UserApi.isKakaoTalkLoginAvailable() {
//                        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
//                            if let token = oauthToken {
//                                print("✅ 앱으로 로그인 성공: \(token.accessToken)")
//                                UserApi.shared.me { user, error in
//                                    if let user = user,
//                                       let nickname = user.kakaoAccount?.profile?.nickname {
//                                        AuthKeyChainService.shared.saveKakaoLoginInfoToKeychain(nickname: nickname, token: token.accessToken)
//                                        
//                                        UserDefaults.standard.set("kakao", forKey: "loginMethod")
//                                        
//                                        isLoggedIn = true
//                                    }
//                                }
//                            }
//                        }
//                    } else {
//                        // 없는 경우
//                        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
//                            if let token = oauthToken {
//                                print("✅ 웹으로 로그인 성공: \(token.accessToken)")
//                                UserApi.shared.me { user, error in
//                                    if let user = user,
//                                       let nickname = user.kakaoAccount?.profile?.nickname {
//                                        AuthKeyChainService.shared.saveKakaoLoginInfoToKeychain(nickname: nickname, token: token.accessToken)
//                                        
//                                        UserDefaults.standard.set("kakao", forKey: "loginMethod")
//                                        
//                                        isLoggedIn = true
//                                    }
//                                }
//                            }
//                        }
//                    }
//                } label: {
//                    SocialLoginButton(title: "카카오 로그인", image: "KakaoLogo", fontcolor: 0x000000, backgroundcolor: 0xFEE500)
//                }
//                
//                SocialLoginButton(title: "Apple로 로그인", image: "AppleLogo", fontcolor: 0xFFFFFF, backgroundcolor: 0x000000)
//            }
//            .frame(width: 306, height: 144)
//        }
//    }
    
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
