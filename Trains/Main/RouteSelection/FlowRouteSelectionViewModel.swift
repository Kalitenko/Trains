import Combine
import SwiftUI
import Foundation

@MainActor
@Observable
final class FlowRouteSelectionViewModel {
    
    let allStationsService: AllStationsServiceProtocol
    
    var settlements: [SettlementItem] = []
    var selectedSettlement: SettlementItem?
    var stations: [StationItem] = []
    
    var settlement: String = ""
    var station: String = ""
    
    var isLoading = false
    
    var error: ErrorType?
    
    let onFinish: (RoutePoint) -> Void
    
    // MARK: - Settings
    var onlyFewCities: Bool {
        get { UserDefaults.standard.bool(forKey: AppStorageKey.fewCities.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: AppStorageKey.fewCities.rawValue) }
    }
    private let cities = ["Москва", "Минск", "Смоленск", "Санкт-Петербург", "Караганды"]
    
    private let transportTypes = ["train", "suburban"]
    private let stationTypes = ["station", "platform", "train_station"]
    
    // MARK: - Network
    let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    
    init(allStationsService: AllStationsServiceProtocol, networkMonitor: NetworkMonitor, onFinish: @escaping (RoutePoint) -> Void) {
        self.allStationsService = allStationsService
        self.onFinish = onFinish
        self.networkMonitor = networkMonitor
    }
    
    func selectSettlement(_ settlement: SettlementItem) {
        selectedSettlement = settlement
        stations = settlement.stations
    }
    
    func selectStation(_ station: StationItem) {
        guard let selectedSettlement else { return }
        finish(settlement: selectedSettlement, station: station)
    }
    
    private func finish(settlement: SettlementItem, station: StationItem) {
        let route = RoutePoint(
            settlement: settlement.title,
            station: station,
        )
        onFinish(route)
    }
    
    func loadSettlements() async {
        guard settlements.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await allStationsService.getAllStations()
            
            let countries = response.countries ?? []
            Logger.debug("counties.count: \(countries.count)")
            
            let regions = countries.flatMap { $0.regions ?? [] }
            Logger.debug("regions.count: \(regions.count)")
            
            let rawSettlements = regions.flatMap { $0.settlements ?? [] }
            Logger.debug("rawSettlements.count: \(rawSettlements.count)")
            
            var mappedSettlements: [SettlementItem] = rawSettlements.compactMap { settlement in
                
                let title = settlement.title
                guard let settlementTitle = title, !settlementTitle.isEmpty else {
                    return nil
                }
                
                let stationItems: [StationItem] =
                (settlement.stations ?? [])
                    .filter {
                        guard let type = $0.transport_type else { return false }
                        return transportTypes.contains(type)
                    }
                    .filter {
                        guard let type = $0.station_type else { return false }
                        return stationTypes.contains(type)
                    }
                    .compactMap { station in
                        guard
                            let code = station.codes?.yandex_code,
                            let title = station.title
                        else { return nil }
                        
                        return StationItem(
                            id: code,
                            title: title
                        )
                    }
                
                guard !stationItems.isEmpty else { return nil }
                
                let id = settlement.codes?.yandex_code ?? UUID().uuidString
                
                return SettlementItem(
                    id: id,
                    title: settlementTitle,
                    stations: stationItems
                )
            }
            
            // MARK: - Apply "few cities" filter
            if onlyFewCities {
                mappedSettlements = mappedSettlements.filter { cities.contains($0.title) }
            }
            
            self.settlements = mappedSettlements
            Logger.debug("settlements.count: \(mappedSettlements.count)")
            
        } catch {
            Logger.error("error: \(error)")
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
