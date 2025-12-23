import Combine
import SwiftUI

@MainActor
@Observable
final class CarrierInfoViewModel {
    
    var carrierName: String
    var email: String
    var phone: String
    var imageURL: URL?
    
    var error: ErrorType? = nil
    
    private let code: String
    private let system: String?
    private let service: CarrierInfoServiceProtocol
    
    // MARK: - Network
    private let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    
    init(
        code: String,
        system: String?,
        service: CarrierInfoServiceProtocol,
        networkMonitor: NetworkMonitor
    ) {
        self.code = code
        self.system = system
        self.service = service
        self.networkMonitor = networkMonitor
        self.carrierName = ""
        self.email = ""
        self.phone = ""
        
        networkMonitor.$isConnected
            .receive(on: RunLoop.main)
            .sink { [weak self] isConnected in
                self?.handleNetworkChange(isConnected)
            }
            .store(in: &cancellables)
    }
    
    func loadInfo() async {
        do {
            let response = try await service.getCarrierInfo(
                code: code,
                system: system
            )
            
            guard let carrier = response.resolvedCarrier else {
                self.error = .serverError
                Logger.error("CarrierResponse resolved to nil carrier")
                return
            }
            
            Logger.debug("carrier: \(carrier)")
            let imageURL = carrier.logo.flatMap(URL.init)
            
            self.carrierName = carrier.title ?? ""
            self.email = carrier.email ?? ""
            self.phone = carrier.phone ?? ""
            self.imageURL = imageURL
            
        } catch {
            self.error = .serverError
            Logger.error("Failed to load carrier info: \(error)")
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
