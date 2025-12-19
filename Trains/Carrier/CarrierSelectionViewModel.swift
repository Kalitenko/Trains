import Combine
import SwiftUI

@MainActor
@Observable
final class CarrierSelectionViewModel {
    
    private let whither: RoutePoint
    private let whence: RoutePoint
    
    // MARK: - UI State
    var carriers: [Carrier]
    var filteredCarriers: [Carrier]
    
    var selectedTimeRanges: Set<DepartureTimeRange> = []
    var selectedOption: TransferOption? = nil
    var showFilters = false
    
    var error: ErrorType? = nil
    
    let title: String
    let onSelect: (Carrier) -> Void
    
    // MARK: - Network
    private let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    
    init(
        whither: RoutePoint,
        whence: RoutePoint,
        networkMonitor: NetworkMonitor,
        onSelect: @escaping (Carrier) -> Void
    ) {
        self.whither = whither
        self.whence = whence
        self.title = "\(self.whither.settlement) (\(self.whither.station))  →  \(self.whence.settlement) (\(self.whence.station))"
        
        
        self.networkMonitor = networkMonitor
        self.onSelect = onSelect
        
        let carriers = Self.makeCarriers()
        self.carriers = carriers
        self.filteredCarriers = carriers
    }
    
    
    private static func makeCarriers() -> [Carrier] {
        [
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
}
