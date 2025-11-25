import SwiftUI

struct DestinationTextView: View {
    
    let placeholder: String
    let settlement: String
    let station: String
    
    private var destination: String {
        if settlement.isEmpty && station.isEmpty {
            return ""
        }
        return "\(settlement) (\(station))"
    }

    var body: some View {
        HStack {
            Text(destination.isEmpty ? placeholder : destination)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(destination.isEmpty ? .appGray : .appBlack)
                .padding(.leading, destination.isEmpty ? 16 : 13)
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
        DestinationTextView(placeholder: "Куда")
            .padding(10)
            .background(Color.yellow)
        
        DestinationTextView(placeholder: "Куда", settlement: "Туда", station: "Вокзал")
            .padding(10)
            .background(Color.yellow)
    }
}
