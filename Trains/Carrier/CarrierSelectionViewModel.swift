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
    var selectedOption: TransferOption?
    var showFilters = false
    
    var error: ErrorType? = nil
    
    let title: String
    var isLoading = false
    
    // MARK: - Network
    let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    let client = APIClientFactory.makeClient()
    
    init(
        whither: RoutePoint,
        whence: RoutePoint,
        scheduleBetweenStationsServiceService: ScheduleBetweenStationsServiceProtocol,
        networkMonitor: NetworkMonitor
    ) {
        self.whither = whither
        self.whence = whence
        self.scheduleService = scheduleBetweenStationsServiceService
        self.title = "\(self.whither.settlement) (\(self.whither.station.title))  →  \(self.whence.settlement) (\(self.whence.station.title))"
        
        self.networkMonitor = networkMonitor
        
        let carriers = [Carrier]()
        self.carriers = carriers
        self.filteredCarriers = carriers
        
        networkMonitor.$isConnected
            .receive(on: RunLoop.main)
            .sink { [weak self] isConnected in
                self?.handleNetworkChange(isConnected)
            }
            .store(in: &cancellables)
    }
    
    func loadSchedule() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let segments = try await scheduleService.getScheduleBetweenStations(
                from: whence.station.id,
                to: whither.station.id,
                when: Date().ISO8601DateString
            )
            
            let carriers: [Carrier] = (segments.segments ?? []).compactMap { segment in
                guard
                    let thread = segment.thread,
                    let carrier = thread.carrier,
                    let carrierName = carrier.title,
                    let departure = segment.departure,
                    let arrival = segment.arrival,
                    let duration = segment.duration,
                    let code = carrier.code.map(String.init)
                else { return nil }
                
                let imageURL = carrier.logo.flatMap(URL.init)
                
                return Carrier(
                    carrierName: carrierName,
                    departure: departure,
                    arrival: arrival,
                    duration: TimeInterval(duration),
                    connectingStation: nil,
                    imageURL: imageURL,
                    code: code
                )
            }
            
            self.carriers = carriers
            applyFilters()
            
        } catch {
            self.error = .serverError
            Logger.error("error: \(error)")
        }
    }
    
    func applyFilters() {
        filteredCarriers = carriers.filter { carrier in
            let timeMatches: Bool
            if selectedTimeRanges.isEmpty {
                timeMatches = true
            } else {
                timeMatches = selectedTimeRanges.contains { range in
                    switch range {
                    case .morning: carrier.departure.isBetween(startHour: 6, endHour: 12)
                    case .day:     carrier.departure.isBetween(startHour: 12, endHour: 18)
                    case .evening: carrier.departure.isBetween(startHour: 18, endHour: 24)
                    case .night:   carrier.departure.isBetween(startHour: 0, endHour: 6)
                    }
                }
            }
            
            let transferMatches: Bool
            if let option = selectedOption {
                switch option {
                case .yes: transferMatches = carrier.hasTransfer
                case .no:  transferMatches = !carrier.hasTransfer
                }
            } else {
                transferMatches = true
            }
            
            return timeMatches && transferMatches
        }
    }
    
    func onAppear() {
        handleNetworkChange(networkMonitor.isConnected)
    }
    
    private func handleNetworkChange(_ isConnected: Bool) {
        guard error != .configurationError else { return }
        error = isConnected ? nil : .noInternet
    }
}
