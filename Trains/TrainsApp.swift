import SwiftUI

@main
struct TrainsApp: App {
    @AppStorage("isDarkTheme") private var isDarkTheme: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LaunchScreenView()
                    .preferredColorScheme(isDarkTheme ? .dark : .light)
            }
        }
    }
}
