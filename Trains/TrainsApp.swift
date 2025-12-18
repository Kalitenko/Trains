import SwiftUI

@main
struct TrainsApp: App {
    @AppStorage(AppStorageKey.isDarkTheme.rawValue) private var isDarkTheme: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LaunchScreenView()
                    .preferredColorScheme(isDarkTheme ? .dark : .light)
            }
            .environmentObject(networkMonitor)
        }
    }
}
