import Foundation
import CoreLocation
import UIKit

class KakaoLocalSearchService {
    static func search(keyword: String, completion: @escaping ([Place]) -> Void) {
        guard let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(query)&radius=5000&page=1&size=15&x=127.06283102249932&y=37.514322572335935"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let clientID = Bundle.main.object(forInfoDictionaryKey: "KAOKAO_NATIVE_APP_KEY") as? String ?? ""
        request.setValue("KakaoAK \(clientID)", forHTTPHeaderField: "Authorization")

        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        let os = "ios"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let bundleID = Bundle.main.bundleIdentifier ?? "unknown.bundle"
        let kaHeader = "sdk/\(appVersion) os/\(os)-\(systemVersion) lang/ko origin/\(bundleID) device/\(model)"
        request.setValue(kaHeader, forHTTPHeaderField: "KA")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(KakaoPlaceResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded.documents)
                }
            }
        }.resume()
    }
}
