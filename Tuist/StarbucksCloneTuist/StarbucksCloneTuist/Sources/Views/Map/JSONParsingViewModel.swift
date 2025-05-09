// json 데이터 파일을 읽어서 mymodel 타입으로 디코딩하고, 디코딩 결과를 myProfile이라는 변수에 저장
import Foundation

@Observable
class JSONParsingViewModel: ObservableObject {
    var mapInfo: MapInfoModel?
    
    func loadMapInfo(completion: @escaping (Result<MapInfoModel, Error>) -> Void) {
        // data.json 파일의 url 경로를 가져옴
        guard let url = Bundle.main.url(forResource: "data", withExtension: "geojson") else {
            print("geojson 파일 없음")
            completion(.failure(NSError(domain: "파일 못찾아요!", code: 404, userInfo: nil)))
            return
        }
        
        do {
            // 찾은 파일(url)을 바탕으로 파일의 내용을 data 타입으로 읽어옴
            let data = try Data(contentsOf: url)
            // 읽은 data를 MyModel 타입으로 디코딩
            let decoded = try JSONDecoder().decode(MapInfoModel.self, from: data)
            // 디코딩 결과를 myProfile에 저장
            self.mapInfo = decoded
            print("디코딩 성공")
            completion(.success(decoded))
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}

