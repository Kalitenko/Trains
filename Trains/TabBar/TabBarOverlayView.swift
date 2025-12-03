import SwiftUI

struct TabBarOverlayView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            line
            HStack {
                Spacer()
                mainButton
                Spacer()
                settingsButton
                Spacer()
            }
        }
        .frame(height: 49)
        .padding(.bottom, 4)
    }
    
    private var mainButton: some View {
        TabBarButton(imageName: "arrow.up.message.fill",
                     isSelected: selectedTab == 0,
                     action: {
            selectedTab = 0
            print(selectedTab)
        })
    }
    
    private var settingsButton: some View {
        TabBarButton(imageName: "gearshape.fill",
                     isSelected: selectedTab == 1,
                     action: {
            selectedTab = 1
            print(selectedTab)
        })
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 0.5)
            .foregroundColor(.appSeparator)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TabBarOverlayView(selectedTab: .constant(0))
}
