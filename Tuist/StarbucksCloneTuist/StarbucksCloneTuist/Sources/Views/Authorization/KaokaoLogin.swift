import Foundation
import Alamofire
import UIKit

func requestKakaoAuthCode() {
    let clientID = Bundle.main.object(forInfoDictionaryKey: "KAOKAO_NATIVE_APP_KEY") as? String ?? ""
    let redirectURI = "starbucksclone://oauth"
    let responseType = "code"
    
    let urlString = """
        https://kauth.kakao.com/oauth/authorize?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=\(responseType)
        """
    
    if let url = URL(string: urlString) {
        UIApplication.shared.open(url)
    } else {
        print ("❌ redirect url 접속 실패")
    }
}

func getKakaoAuthCode(_ url: URL, onCodeReceived: @escaping (String) -> Void) {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
        print("❌ 인가 코드 추출 실패")
        return
    }
    
    print("🎯 인가 코드 수신 성공: \(code)")
    onCodeReceived(code)
}

struct KakaoTokenResponse: Codable {
    let token_type: String
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let refresh_token_expires_in: Int
}

func requestKakaoToken(authCode: String) {
    let clientID = Bundle.main.object(forInfoDictionaryKey: "KAOKAO_NATIVE_APP_KEY") as? String ?? ""
    let kakaoUrl = "https://kauth.kakao.com/oauth/token"
    
    let parameters: [String:String] = [
        "grant_type" : "authorization_code",
        "client_id" : clientID,
        "redirect_uri" : "starbucksclone://oauth",
        "code": authCode
    ]
    
    AF.request(kakaoUrl, method: .post, parameters: parameters)
        .responseDecodable(of: KakaoTokenResponse.self) { response in
            switch response.result {
                case .success(let tokenResponse): print("카카오톡 access token 발급 성공: \(tokenResponse.access_token)")
                case .failure(let error): print("카카오톡 access token 발급 실패: \(error)")
            }
        }
}
