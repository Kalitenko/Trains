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
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    VStack(spacing: 20) {
        RoutePointsSelectionView(
            whither: .constant(.empty),
            whence: .constant(.empty),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.cyan)
        
        let whither = RoutePoint(settlement: "Москва", station: StationItem(id: "", title: "Ярославский вокзал"))
        let whence = RoutePoint(settlement: "Санкт Петербург", station: StationItem(id: "", title: "Балтийский вокзал"))
        
        RoutePointsSelectionView(
            whither: .constant(whither),
            whence: .constant(whence),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.secondary)
    }
}
