import Foundation

// 단일 책임 원칙 - 이렇게 하면 안됨! 홈뷰에서는 모든 내용이 필요 없으니까 홉뷰, 디테일 뷰 모델을 따로 만들어야 함
// 그 두개는 맵핑이 크게 연결해주며, id로 세부적인 뷰를 연결 (이건 서버가 따로 있을 때의 얘기, 그래서 프론트 작업 전에 서버의 데이터베이스를 먼저 봐야함)
// id도 서버로부터 갖고 온 Id를 그대로 쓰면 안되고 uuid를 써야함. 왜냐면 디테일 뷰에서 뒤로가기 눌러도 id는 1초 정도 남아있기 때문에 그 사이에 다른 뷰 누르면 전 id가 실행됨
// uuid는 로컬임. uuid를 쓴 후 -> 서버로부터 갖고 온 id를 불러오는 식인거임. (uuid + 서버 id 같이 쓰는 것)

struct ScrollMenuItem: Identifiable {
    let id: Int
    let imageName: String
    let imageDetailName: String?
    let menuName: String
    let englishName: String?
    let price: Int?
    let menudescription: String?
    let isHotAvailable: Bool?
    let isIcedAvailable: Bool?
}

struct ScrollDessertMenuItem: Identifiable {
    let id: Int
    let imageName: String
    let menuName: String
}

struct HomeEventItem: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let eventName: String
    let eventDescription: String
}

struct HomeScrollMenuItem: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let menuName: String
}

struct HomeScrollBestItem: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let menuName: String
    let volume: Int?
}
