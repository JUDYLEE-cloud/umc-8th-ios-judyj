import Foundation
import Security
import KakaoSDKCommon
import KakaoSDKAuth
import Alamofire

class AuthKeyChainService {
    static let shared = AuthKeyChainService()
    
    // 일반 로그인
    @discardableResult
    func saveLoginInfoToKeychain(nickname: String, id: String, password: String) -> OSStatus {
        let loginInfo: [String : String] = [
            "nickname" : nickname,
            "id" : id,
            "password" : password
        ]
        // 1. 저장할 데이터를 데이터 타입으로 변환
        guard let loginInfoData = try? JSONSerialization.data(withJSONObject: loginInfo, options: []) else {
            return errSecParam
        }
        
        // 2. 키체인 딕셔너리 구성
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: id,
            kSecValueData as String: loginInfoData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // 3. 이미 같은 항목이 있다면 이전것 삭제
        SecItemDelete(query as CFDictionary)
        
        // 4. 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        return status
    }
    
    // 일반 로그인 정보 가져오기
    @discardableResult
    func getNicknameFromKeychain() -> String? {
        // 1. 검색 쿼리 구성
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnData as String: true,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // 2. 검색 결과 저장 변수
        var items: CFTypeRef?
        
        // 3. 항목 검색
        let status = SecItemCopyMatching(query as CFDictionary, &items)
        
        // 4. 상태 확인 및 결과 처리
        guard status == errSecSuccess else {
            print("❌ Login Keychain load 실패 - \(status)")
            return nil
        }
        
        // 5. data를 string으로 변환 및 kakao 항목 제외 후 반환
        guard let dataArray = items as? [Data] else {
            print("❌ Login Keychain load 디코딩 실패 - 데이터 배열 변환 실패")
            return nil
        }
        
        for data in dataArray {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []),
               let result = json as? [String : String],
               let nickname = result["nickname"],
               let accountId = result["id"],
               accountId != "kakao" {
                return nickname
            }
        }
        print("❌ Login Keychain load 실패 - kakao 항목 외에 닉네임 없음")
        return nil
    }
    
    
    // 카카오 로그인
    @discardableResult
    func saveKakaoLoginInfoToKeychain(nickname: String, token: String) -> OSStatus {
        let loginInfo: [String : String] = [
            "nickname" : nickname,
            "token" : token
        ]
        
        guard let loginInfoData = try? JSONSerialization.data(withJSONObject: loginInfo, options: []) else {
            print("❌ JSON 변환 실패")
            return errSecParam
        }
        
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "kakao",
            kSecValueData as String: loginInfoData,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        print("🔐 키체인 저장 상태: \(status == errSecSuccess ? "성공" : "실패(\(status))")")
        
        
        return status
    }
    
    // 카카오 로그인 닉네임 가져오기
    func getKakaoNicknameFromKeychain() -> String? {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "kakao",  // "kakao" 항목만 조회
            kSecReturnData as String: true,  // 데이터 반환
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        var item: CFTypeRef?
        
        // 키체인에서 항목을 검색
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            print("❌ 키체인 로드 실패 - 상태 코드: \(status)")
            return nil
        }
        
        // 저장된 데이터를 디코딩하여 출력
        guard let data = item as? Data,
              let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let result = json as? [String: String],
              let nickname = result["nickname"] else {
            print("❌ 키체인 디코딩 실패")
            return nil
        }
        
        print("✅ 키체인에서 로드된 닉네임: \(nickname)")
        return nickname
    }
    
    
    func loadNicknameFromKeychain() -> String? {
        let loginMethod = UserDefaults.standard.string(forKey: "loginMethod")
        
        if loginMethod == "kakao" {
            print("🔍 로그인 방식: 카카오")
            return getKakaoNicknameFromKeychain()
        } else if loginMethod != nil {
            print("🔍 로그인 방식: 일반")
            return getNicknameFromKeychain()
        } else {
            print("⚠️ 로그인 방식 미확인 - 둘 다 시도")
            
            if let kakaoNickname = getKakaoNicknameFromKeychain() {
                print("✅ (fallback) 카카오 닉네임 로드 성공")
                return kakaoNickname
            }
            if let normalNickname = getNicknameFromKeychain() {
                print("✅ (fallback) 일반 닉네임 로드 성공")
                return normalNickname
            }
            print("❌ 닉네임 로드 실패 - 아무 것도 없음")
            return nil
        }
    }
    
}
