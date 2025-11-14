import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String, when date: String?) async throws -> ScheduleResponse
}

final class StationScheduleService: StationScheduleServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getStationSchedule(station: String, when date: String? = nil) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
