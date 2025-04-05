import Foundation
import SwiftUI
import Observation

enum Route: Hashable {
    case home
    case detail(title: String)
    case profile(userID: Int)
}

@Observable
class NavigationRouter {
    var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    func reset() {
        path = NavigationPath()
    }
}

