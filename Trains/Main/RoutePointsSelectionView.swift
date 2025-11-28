import SwiftUI

struct RoutePointsSelectionView: View {
    
    @Binding var whither: RoutePoint
    @Binding var whence: RoutePoint
    let whitherAction: () -> Void
    let whenceAction: () -> Void
    let swapAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            RoutePointsStackView(
                whither: whither,
                whence: whence,
                whitherAction: whitherAction,
                whenceAction: whenceAction)
            SwapButton(action: swapAction)
        }
        .padding(16)
        .background(Color.appBlue)
        .cornerRadius(20)
        
    }
}

#Preview {
    VStack(spacing: 20) {
        RoutePointsSelectionView(
            whither: .constant(RoutePoint()),
            whence: .constant(RoutePoint()),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.cyan)
        
        RoutePointsSelectionView(
            whither: .constant(RoutePoint(settlement: "Москва", station: "Курский")),
            whence: .constant(RoutePoint(settlement: "Сочи", station: "Альпика")),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.secondary)
    }
}
