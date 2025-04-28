import Foundation

struct OrderDrinkMenuItem: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let menuName: String
    let englishName: String
    let new: Bool
}
