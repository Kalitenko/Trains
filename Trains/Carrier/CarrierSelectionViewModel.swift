import Combine
import SwiftUI

@MainActor
@Observable
final class CarrierSelectionViewModel {
    
    private let whither: RoutePoint
    private let whence: RoutePoint
    private let scheduleService: ScheduleBetweenStationsServiceProtocol
    
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
        scheduleBetweenStationsServiceService: ScheduleBetweenStationsServiceProtocol,
        networkMonitor: NetworkMonitor,
        onSelect: @escaping (Carrier) -> Void
    ) {
        self.whither = whither
        self.whence = whence
        self.scheduleService = scheduleBetweenStationsServiceService
        self.title = "\(self.whither.settlement) (\(self.whither.station.title))  →  \(self.whence.settlement) (\(self.whence.station.title))"
        
        
        self.networkMonitor = networkMonitor
        self.onSelect = onSelect
        
        let carriers = [Carrier]()
        self.carriers = carriers
        self.filteredCarriers = carriers
    }
    
    func loadSchedule() async {
        do {
            let segments = try await scheduleService.getScheduleBetweenStations(
                from: whence.station.id,
                to: whither.station.id,
                when: nil
            )
            
            let carriers: [Carrier] = (segments.segments ?? []).compactMap { segment in
                guard
                    let thread = segment.thread,
                    let carrier = thread.carrier,
                    let carrierName = carrier.title,
                    let departure = segment.departure,
                    let arrival = segment.arrival,
                    let duration = segment.duration
                else { return nil }
                
                let imageURL = carrier.logo.flatMap(URL.init)
                
                return Carrier(
                    carrierName: carrierName,
                    departure: departure,
                    arrival: arrival,
                    duration: TimeInterval(duration),
                    connectingStation: nil,
                    imageURL: imageURL
                )
            }
            
            self.carriers = carriers
            self.filteredCarriers = carriers
            
        } catch {
            self.error = .serverError
            Logger.error("error: \(error)")
        }
    }
}
