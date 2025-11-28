import SwiftUI

struct RoutePointsStackView: View {
    
    let whitherRoutePoint: RoutePoint
    let whenceRoutePoint: RoutePoint
    
    let whitherAction: () -> Void
    let whenceAction: () -> Void
    
    private let whencePlaceholder = "Откуда"
    private let whitherPlaceholder = "Куда"
    
    var body: some View {
        VStack(spacing: 0) {
            RoutePointButton(
                view: RoutePointView(
                    placeholder: whencePlaceholder,
                    settlement: whenceRoutePoint.settlement,
                    station: whenceRoutePoint.station
                ),
                action: whenceAction
            )
            
            RoutePointButton(
                view: RoutePointView(
                    placeholder: whitherPlaceholder,
                    settlement: whitherRoutePoint.settlement,
                    station: whitherRoutePoint.station
                ),
                action: whitherAction
            )
        }
        .background(Color.appWhite)
        .cornerRadius(20)
    }
    
    init(whither whitherRoutePoint: RoutePoint,
         whence whenceRoutePoint: RoutePoint,
         whitherAction: @escaping () -> Void,
         whenceAction: @escaping () -> Void) {
        self.whitherRoutePoint = whitherRoutePoint
        self.whenceRoutePoint = whenceRoutePoint
        self.whitherAction = whitherAction
        self.whenceAction = whenceAction
    }
}

#Preview {
    VStack(spacing: 20) {
        RoutePointsStackView(
            whither: RoutePoint(),
            whence: RoutePoint(),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") }
        )
        .padding(10)
        .background(Color.yellow)
        
        RoutePointsStackView(
            whither: RoutePoint(settlement: "Москва", station: "Курский"),
            whence: RoutePoint(settlement: "Сочи", station: "Альпика"),
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") }
        )
        .padding(10)
        .background(Color.red)
    }
}
