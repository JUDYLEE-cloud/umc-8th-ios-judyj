import SwiftUI

struct RouterView: View {
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Button("Go to Home") {
                    router.push(.home)
                }
                Button("Go to Detail") {
                    router.push(.detail(title: "SwfitUI Navigation"))
                }
                Button("Go to Profile") {
                    router.push(.profile(userID: 123))
                }
                Button("Reset Navigation") {
                    router.reset()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .detail(let title):
                    UserDetailView(title: title)
                case .profile(let userID):
                    ProfileView(userID: userID)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text("my home!!!")
        }
    }
}


struct UserDetailView: View {
    let title: String

    var body: some View {
        VStack {
            Text("This is \(title) View")
                .font(.largeTitle)
        }
        .navigationTitle(title)
    }
}

struct ProfileView: View {
    let userID: Int

    var body: some View {
        VStack {
            Text("User ID: \(userID)")
                .font(.largeTitle)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    RouterView()
}

