import SwiftUI

@main
struct QuickCareApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.olive.ignoresSafeArea()
                LoginView()
            }
        }
    }
}
