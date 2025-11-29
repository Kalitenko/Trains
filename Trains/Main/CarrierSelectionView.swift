import SwiftUI

struct CarrierSelectionView: View {
    
    let title: String
    let carriers: [Carrier]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.bold24)
            List(carriers, id: \.self) { carrier in
                CarrierSelectionRowView(carrier: carrier)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.appBackground)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    
    let carriers: [Carrier] = [
        Carrier(carrierName: "РЖД", startTime: "22:30", finishTime: "08:15", duration: "20 часов",
                date: "14 января", connectingStation: "С пересадкой в Костроме", imageName: "rzd"),
        Carrier(carrierName: "ФГК", startTime: "01:15", finishTime: "09:00", duration: "9 часов",
                date: "15 января", connectingStation: nil, imageName: "fgk"),
        Carrier(carrierName: "Урал логистика", startTime: "12:30", finishTime: "21:00", duration: "20 часов",
                date: "16 января", connectingStation: nil, imageName: "ural"),
        Carrier(carrierName: "РЖД", startTime: "22:30", finishTime: "08:15", duration: "9 часов",
                date: "17 января", connectingStation: nil, imageName: "rzd"),
        Carrier(carrierName: "4321", startTime: "22:30", finishTime: "08:15", duration: "20 часов",
                date: "33 января", connectingStation: "С пересадкой в Костроме", imageName: "rzd"),
        Carrier(carrierName: "1234", startTime: "22:30", finishTime: "08:15", duration: "20 часов",
                date: "33 января", connectingStation: "С пересадкой в Костроме", imageName: "rzd")
    ]
    
    CarrierSelectionView(
        title: "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)",
        carriers: carriers
    )
}
