import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let kakaoAPIKey: String = {
        guard let kakaoAPIKey = Config.infoDictionary["kakaoAPIKey"] as? String else {
            fatalError()
        }
        return kakaoAPIKey
    }()
}
