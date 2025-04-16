import Foundation
import SwiftUI

extension HomeScrollMenuItem {
    static let homeMenuImages: [HomeScrollMenuItem] = [
        HomeScrollMenuItem(imageName: "homeproduct1", menuName: "텀블러"),
        HomeScrollMenuItem(imageName: "homeproduct2", menuName: "커피 용품"),
        HomeScrollMenuItem(imageName: "homeproduct3", menuName: "선물세트"),
        HomeScrollMenuItem(imageName: "homeproduct4", menuName: "보온병"),
        HomeScrollMenuItem(imageName: "homeproduct5", menuName: "머그/컵"),
        HomeScrollMenuItem(imageName: "homeproduct6", menuName: "라이프스타일"),
    ]
}

extension HomeScrollBestItem {
    static let homeBestImages: [HomeScrollBestItem] = [
        HomeScrollBestItem(imageName: "homebest1", menuName: "그린 사이렌 슬리브 머그", volume: 355),
        HomeScrollBestItem(imageName: "homebest2", menuName: "그린 사이렌 클래식 머그", volume: 355),
        HomeScrollBestItem(imageName: "homebest3", menuName: "사이렌 머그 앤 우드 소서", volume: nil),
        HomeScrollBestItem(imageName: "homebest4", menuName: "리저브 골드 테일 머그", volume: 355),
        HomeScrollBestItem(imageName: "homebest5", menuName: "블랙 앤 골드 머그", volume: 473),
        HomeScrollBestItem(imageName: "homebest6", menuName: "블랙 링 머그", volume: 355),
        HomeScrollBestItem(imageName: "homebest7", menuName: "북청사자놀음 데이머그", volume: 89),
        HomeScrollBestItem(imageName: "homebest8", menuName: "서울 제주 데미머그 세트", volume: nil)
        ]
    
    static let homenewImages: [HomeScrollBestItem] = [
        HomeScrollBestItem(imageName: "homenew1", menuName: "그린 사이렌 도트 머그", volume: 237),
        HomeScrollBestItem(imageName: "homenew2", menuName: "그린 사이렌 도트 머그", volume: 355),
        HomeScrollBestItem(imageName: "homenew3", menuName: "홈 카페 미니 머그 세트", volume: nil),
        HomeScrollBestItem(imageName: "homenew4", menuName: "홈 카페 글라스 세트", volume: nil)
    ]
}

    

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

extension HomeEventItem {
    static let sampleEventItems: [HomeEventItem] = [
        HomeEventItem(imageName: "event1", eventName: "25년 3월 일회용컵 없는 날 캠페인", eventDescription: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        HomeEventItem(imageName: "event2", eventName: "스타벅스 ooo점을 찾습니다", eventDescription: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        HomeEventItem(imageName: "event3", eventName: "2월 8일, 리저브 스프링 신규 커피 대공개", eventDescription: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")]
}

