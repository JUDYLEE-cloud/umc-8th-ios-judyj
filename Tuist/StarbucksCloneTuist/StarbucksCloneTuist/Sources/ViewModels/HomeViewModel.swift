import Foundation
import SwiftUI

extension ScrollMenuItem {
    static let drinkMenuImages: [ScrollMenuItem] = [
        ScrollMenuItem(id: 101, imageName: "menu1", imageDetailName: "menu1detail", menuName: "에스프레소 콘파나", englishName: "Espresso Con Panna", price: 4100, menudescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", isHotAvailable: true, isIcedAvailable: false),
        ScrollMenuItem(id: 102, imageName: "menu2", imageDetailName: "menu2detail", menuName: "에스프레소 마키아또", englishName: "Espresso Macchiato", price: 3900, menudescription: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", isHotAvailable: false, isIcedAvailable: true),
        
        // 아메리카노
        ScrollMenuItem(id: 103, imageName: "menu3", imageDetailName: "menu3detail", menuName: "아이스 카페 아메리카노", englishName: "Iced Caffe Americano", price: 4700, menudescription: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", isHotAvailable: true, isIcedAvailable: true),
        ScrollMenuItem(id: 104, imageName: "menu4", imageDetailName: "menu4detail", menuName: "카페 아메리카노", englishName: "Caffe Americano", price: 4700, menudescription: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", isHotAvailable: true, isIcedAvailable: true),
        
        // 카라멜 마끼아또
        ScrollMenuItem(id: 105, imageName: "menu5", imageDetailName: "menu5detail", menuName: "아이스 카라멜 마끼아또", englishName: "Iced Caramel Macchiato", price: 6100, menudescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", isHotAvailable: true, isIcedAvailable: true),
        ScrollMenuItem(id: 106, imageName: "menu6", imageDetailName: "menu6detail", menuName: "카라멜 마끼아또", englishName: "Caramel Macchiato", price: 6100, menudescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", isHotAvailable: true, isIcedAvailable: true),
    ]
    static let dessertMenuImages: [ScrollMenuItem] = [
        ScrollMenuItem(id: 1, imageName: "dessert1", imageDetailName: nil, menuName: "너티 크루아상", englishName: nil, price: nil, menudescription: nil, isHotAvailable: nil, isIcedAvailable: nil),
        ScrollMenuItem(id: 2, imageName: "dessert2", imageDetailName: nil, menuName: "매콤 소시지 불고기", englishName: nil, price: nil, menudescription: nil, isHotAvailable: nil, isIcedAvailable: nil),
        ScrollMenuItem(id: 3, imageName: "dessert3", imageDetailName: nil, menuName: "미니 리프 파이", englishName: nil, price: nil, menudescription: nil, isHotAvailable: nil, isIcedAvailable: nil),
        ScrollMenuItem(id: 4, imageName: "dessert4", imageDetailName: nil, menuName: "뺑 오 쇼콜라", englishName: nil, price: nil, menudescription: nil, isHotAvailable: nil, isIcedAvailable: nil),
        ScrollMenuItem(id: 5, imageName: "dessert5", imageDetailName: nil, menuName: "소시지&올리브 파이", englishName: nil, price: nil, menudescription: nil, isHotAvailable: nil, isIcedAvailable: nil)
    ]
}

extension EventItem {
    static let sampleEventItems: [EventItem] = [
        EventItem(imageName: "event1", eventName: "25년 3월 일회용컵 없는 날 캠페인", eventDescription: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        EventItem(imageName: "event2", eventName: "스타벅스 ooo점을 찾습니다", eventDescription: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        EventItem(imageName: "event3", eventName: "2월 8일, 리저브 스프링 신규 커피 대공개", eventDescription: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")]
}
