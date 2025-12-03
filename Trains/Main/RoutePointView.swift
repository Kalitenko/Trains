import SwiftUI

struct RoutePointView: View {
    
    let placeholder: String
    let settlement: String
    let station: String
    
    private var routePoint: String {
        guard !(settlement.isEmpty && station.isEmpty) else {
            return ""
        }
        return "\(settlement) (\(station))"
    }
    
    var body: some View {
        HStack {
            Text(routePoint.isEmpty ? placeholder : routePoint)
                .font(.regular17)
                .foregroundStyle(routePoint.isEmpty ? .appGray : .appBlack)
                .padding(.leading, routePoint.isEmpty ? 16 : 13)
            Spacer()
        }
        .padding(.vertical, 14)
        .background(Color.appWhite)
    }
    
    init(placeholder: String, settlement: String = "", station: String = "") {
        self.placeholder = placeholder
        self.settlement = settlement
        self.station = station
    }
}

#Preview {
    VStack(spacing: 20) {
        RoutePointView(placeholder: "Куда")
            .padding(10)
            .background(Color.yellow)
        
        RoutePointView(placeholder: "Куда", settlement: "Туда", station: "Вокзал")
            .padding(10)
            .background(Color.yellow)
    }
}
