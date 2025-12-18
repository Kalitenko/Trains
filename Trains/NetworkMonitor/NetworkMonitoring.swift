import Network
import Combine

public protocol NetworkMonitoring {
    var isConnected: Bool { get }
}

public final class NetworkMonitor: ObservableObject, NetworkMonitoring {
    
    @Published public private(set) var isConnected: Bool = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    public init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                Logger.debug("🌐 path status: \(path.status)")
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
