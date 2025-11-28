import SwiftUI

struct MainView: View {
    
    @State private var whither = RoutePoint()
    @State private var whence = RoutePoint()
    
    private var buttonIsEnabled: Bool {
        !whither.settlement.isEmpty && !whence.settlement.isEmpty
        && !whither.station.isEmpty && !whence.station.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 16) {
            RoutePointsSelectionView(
                whither: $whither,
                whence: $whence,
                whitherAction: { print("tap куда") },
                whenceAction: { print("tap откуда") },
                swapAction: { swap() }
            )
            .padding(.top, 20)
            
            if buttonIsEnabled {
                PrimaryButton(title: "Найти",
                              action: {
                    print("Найти tapped")
                },
                              width: 150)
            }
            Spacer()
        }
    }
    
    private func swap() {
        let temp = whither
        whither = whence
        whence = temp
    }
}

#Preview {
    MainView()
}
