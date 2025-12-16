import SwiftUI

struct TabBarOverlayView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 10) {
            line
            HStack {
                Spacer()
                mainButton
                Spacer()
                Spacer()
                settingsButton
                Spacer()
            }
        }
        .frame(height: Constants.customTabBarHeight)
        .padding(.bottom, 4)
    }
    
    private var mainButton: some View {
        TabBarButton(isSystemName: true,
                     imageName: "arrow.up.message.fill",
                     isSelected: selectedTab == 0,
                     action: {
            selectedTab = 0
        })
    }
    
    private var settingsButton: some View {
        TabBarButton(isSystemName: false,
                     imageName: "settings",
                     isSelected: selectedTab == 1,
                     action: {
            selectedTab = 1
        })
    }
    
    private var line: some View {
        Line(color: .appSeparator, height: 0.5)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TabBarOverlayView(selectedTab: .constant(0))
}
