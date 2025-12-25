import Combine
import SwiftUI
import Foundation

@MainActor
final class AgreementViewModel: ObservableObject {
    
    @Published var error: ErrorType? = nil
    let url: URL?
    
    private let networkMonitor: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()
    
    init(networkMonitor: NetworkMonitor) {
        self.networkMonitor = networkMonitor
        if let validURL = URL(string: "https://yandex.ru/legal/practicum_offer/ru/") {
            self.url = validURL
        } else {
            self.url = nil
            self.error = .configurationError
            return
        }
        
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
        guard error != .configurationError else { return }
        error = isConnected ? nil : .noInternet
    }
}
