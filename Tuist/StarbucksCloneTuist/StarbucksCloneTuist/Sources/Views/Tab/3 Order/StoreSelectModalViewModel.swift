import Foundation

@MainActor
final class StoreSelectModalViewModel: ObservableObject {
    @Published var storeImageURL: URL? = nil
    private let googleService = GooglePlaceImageService()

    func loadImage(for storeName: String) async {
        let keyword = "\(storeName) 스타벅스"
        
        do {
            guard let placeId = try await googleService.fetchPlaceId(for: keyword) else { return }
            guard let photoName = try await googleService.fetchPhotoName(for: placeId) else { return }
            guard let imageURL = googleService.getPhotoURL(photoName: photoName) else { return }
            self.storeImageURL = imageURL
        } catch {
            print("🚨 이미지 로딩 실패: \(error)")
        }
    }
}

// MARK: - Text Search 응답 모델
struct GooglePlaceTextSearchResponse: Decodable {
    let places: [Place]?
    struct Place: Decodable {
        let id: String
    }
}

// MARK: - Detail 응답 모델
struct GooglePlaceDetailResponse: Decodable {
    let photos: [Photo]?
    struct Photo: Decodable {
        let name: String
    }
}
