import Foundation

final class RouteViewModel: ObservableObject {
    private let provider = APIManager.shared.createProvider(for: RouteRouter.self)

    @Published var routeData: RouteResponse?
    @Published var errorMessage: String?

    func fetchRoute(from start: Coordinate, to end: Coordinate, completion: (()-> Void)? = nil) {
        provider.request(.fetchRoute(start: start, end: end)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(RouteResponse.self, from: response.data)
                    DispatchQueue.main.async {
                        self.routeData = decoded
                        completion?()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "디코딩 에러: \(error.localizedDescription)"
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "네트워크 에러: \(error.localizedDescription)"
                }
            }
        }
    }
}
