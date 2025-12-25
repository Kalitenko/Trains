typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol: Sendable {
    func getAllStations() async throws -> AllStations
}
