import SwiftUI

struct CarrierSelectionView: View {
    
    let title: String
    let carriers: [Carrier]
    let onSelect: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var showFilters = false
    
    @State private var selectedTimeRanges: Set<DepartureTimeRange> = []
    @State private var selectedOption: TransferOption?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                titleView
                list
            }
            .background(Color.appBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if carriers.isEmpty {
                    noOptionsText
                }
            }
            
            .backButtonToolbar(dismiss)
            button
        }
        .fullScreenCover(isPresented: $showFilters) {
            NavigationStack {
                FilterView(
                    selectedTimeRanges: $selectedTimeRanges,
                    selectedOption: $selectedOption
                )
            }
        }
    }
    
    private var titleView: some View {
        Text(title)
            .font(.bold24)
            .padding(.horizontal, 16)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var noOptionsText: some View {
        Text("Вариантов нет")
            .font(.bold24)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var list: some View {
        
        List(carriers, id: \.self) { carrier in
            Button {
                onSelect(carrier.carrierName)
            } label: {
                CarrierSelectionRowView(carrier: carrier)
                
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.appBackground)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        }
        
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    
    private var button: some View {
        PrimaryButton(
            title: "Уточнить время",
            showDot: isDotShown
        ) {
            showFilters = true
        }
    }
    
    private var isDotShown: Bool {
        selectedOption != nil || !selectedTimeRanges.isEmpty
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
    NavigationStack {
        CarrierSelectionView(
            title: "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)",
            carriers: carriers,
            onSelect: { name in
                print("Выбран перевозчик \(name)")
            }
        )
        .preferredColorScheme(.dark)
    }
}
