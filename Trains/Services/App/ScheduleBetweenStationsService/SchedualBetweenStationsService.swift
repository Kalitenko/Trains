import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, when date: String? = nil) async throws -> Segments {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}
