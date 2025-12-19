import Combine
import SwiftUI
import Foundation

@MainActor
@Observable
final class MainViewModel {
    
    // MARK: - State
    var whither = RoutePoint()
    var whence = RoutePoint()
    var error: ErrorType?
    
    var showFlow = false
    var showCarriers = false
    var showCarrierInfo = false
    
    var isSearchEnabled: Bool {
        !whither.settlement.isEmpty &&
        !whence.settlement.isEmpty &&
        !whither.station.isEmpty &&
        !whence.station.isEmpty
    }
    
    // MARK: - Network
    private let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    
    init(networkMonitor: NetworkMonitor) {
        self.networkMonitor = networkMonitor
        
        networkMonitor.$isConnected
            .receive(on: RunLoop.main)
            .sink { [weak self] isConnected in
                self?.handleNetworkChange(isConnected)
            }
            .store(in: &cancellables)
    }
    
    func onAppear() {
        handleNetworkChange(networkMonitor.isConnected)
    }
    
    private func handleNetworkChange(_ isConnected: Bool) {
        error = isConnected ? nil : .noInternet
    }
}
