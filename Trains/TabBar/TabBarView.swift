import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView(viewModel: MainViewModel(networkMonitor: networkMonitor))
                .tag(0)
                .tabItem {
                    EmptyView()
                }
            SettingsView()
                .tag(1)
                .tabItem {
                    EmptyView()
                }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .appBackground()
        .overlay(alignment: .bottom) {
            TabBarOverlayView(selectedTab: $selectedTab)
        }
        
    }
}

#Preview {
    TabBarView()
        .preferredColorScheme(ColorScheme.dark)
        .environmentObject(NetworkMonitor())
}

