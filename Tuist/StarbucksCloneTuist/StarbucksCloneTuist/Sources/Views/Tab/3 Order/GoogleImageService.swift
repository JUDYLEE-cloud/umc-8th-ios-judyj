import Foundation

final class GooglePlaceImageService {
    
    private let session = URLSession.shared
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String ?? ""

    // 1. Text Search → placeId 가져오기
    func fetchPlaceId(for keyword: String) async throws -> String? {
        let base = "https://places.googleapis.com/v1/places:searchText"
        let url = URL(string: base)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "textQuery": keyword,
            "languageCode": "ko",
            "regionCode": "KR"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await session.data(for: request)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print("🔍 [fetchPlaceId] Response JSON: \(String(describing: json))")

        
        let result = try JSONDecoder().decode(GooglePlaceTextSearchResponse.self, from: data)
        return result.places?.first?.id
    }

    // 2. placeId로 → photoName 가져오기
    func fetchPhotoName(for placeId: String) async throws -> String? {
        guard let url = URL(string: "https://places.googleapis.com/v1/places/\(placeId)?fields=photos&key=\(apiKey)") else { return nil }

        let (data, _) = try await session.data(from: url)
        let json = try? JSONSerialization.jsonObject(with: data, options: []) // ✅ 로그 찍기
        print("🔍 [fetchPhotoName] Response JSON: \(String(describing: json))")

        
        let result = try JSONDecoder().decode(GooglePlaceDetailResponse.self, from: data)
        return result.photos?.first?.name
    }

    // 3. photoName → 이미지 URL 반환
    func getPhotoURL(photoName: String, maxWidth: Int = 400) -> URL? {
        let encodedPhotoName = photoName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let urlStr = "https://places.googleapis.com/v1/\(encodedPhotoName)/media?maxWidthPx=\(maxWidth)&key=\(apiKey)"
        return URL(string: urlStr)
    }
}
