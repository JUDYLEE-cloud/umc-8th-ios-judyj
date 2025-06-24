import Foundation
import SwiftUI
import Observation

enum Route: Hashable {
    case signup
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
