import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
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
}
