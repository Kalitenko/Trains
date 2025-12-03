import SwiftUI


struct MainView: View {
    
    @State private var whither = RoutePoint()
    @State private var whence = RoutePoint()
    
    @State private var showFlow = false
    @State private var isWhitherFlow = true
    @State private var showCarriers = false
    @State private var showCarrierInfo = false
    
    private var buttonIsEnabled: Bool {
        !whither.settlement.isEmpty && !whence.settlement.isEmpty
        && !whither.station.isEmpty && !whence.station.isEmpty
    }
    
    var body: some View {
        ParentContainer {
            VStack(spacing: 16) {
                RoutePointsSelectionView(
                    whither: $whither,
                    whence: $whence,
                    whitherAction: {
                        isWhitherFlow = true
                        showFlow = true
                    },
                    whenceAction: {
                        isWhitherFlow = false
                        showFlow = true
                    },
                    swapAction: { swap() }
                )
                .padding(.horizontal, 16)
                .fullScreenCover(isPresented: $showFlow) {
                    FlowView { settlement, station in
                        if isWhitherFlow {
                            whither.settlement = settlement
                            whither.station = station
                        } else {
                            whence.settlement = settlement
                            whence.station = station
                        }
                        showFlow = false
                    }
                }
                .fullScreenCover(isPresented: $showCarriers) {
                    let title = "\(whither.settlement) (\(whither.station))  →  \(whence.settlement) (\(whence.station))"
                    NavigationStack {
                        CarrierSelectionView(title: title, carriers: carriers) { carrierName in
                            Logger.info("Выбран \(carrierName)")
                            showCarrierInfo = true
                        }
                        .navigationDestination(isPresented: $showCarrierInfo) {
                            CarrierInfoView()
                        }
                    }
                }
                .padding(.top, 20)
                
                PrimaryButton(
                    title: "Найти",
                    width: 150) {
                        showCarriers = true
                    }
                    .opacity(buttonIsEnabled ? 1 : 0)
                
                Spacer()
            }
            .appBackground()
        }
    }
    
    private func swap() {
        let temp = whither
        whither = whence
        whence = temp
    }
    
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
}

private struct FlowView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var path = NavigationPath()
    
    let onFinish: (String, String) -> Void
    
    @State private var selectedSettlement = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            SettlementSelectionView { settlement in
                selectedSettlement = settlement
                path.append("station")
            }
            .navigationDestination(for: String.self) { value in
                if value == "station" {
                    StationSelectionView { station in
                        onFinish(selectedSettlement, station)
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
