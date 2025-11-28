import SwiftUI

struct RoutePointButton: View {
    
    let routePointView: RoutePointView
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            routePointView
        })
    }
    
    init(view routePointView: RoutePointView, action: @escaping () -> Void) {
        self.routePointView = routePointView
        self.action = action
    }
}

#Preview {
    RoutePointButton(
        view: RoutePointView(placeholder: "Куда"),
        action: {
            print("DestinationButton tapped")
    })
    .padding(10)
    .background(Color.yellow)
}
