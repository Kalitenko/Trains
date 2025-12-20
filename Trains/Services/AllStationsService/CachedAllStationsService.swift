actor CachedAllStationsService: AllStationsServiceProtocol {

    private let remote: AllStationsServiceProtocol
    private var cached: AllStations?

    init(remote: AllStationsServiceProtocol) {
        self.remote = remote
    }

    func getAllStations() async throws -> AllStations {
        if let cached {
            return cached
        }

        let result = try await remote.getAllStations()
        cached = result
        return result
    }
}
