typealias Segments = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol: Sendable {
    func getScheduleBetweenStations(from: String, to: String, when date: String?) async throws -> Segments
}
