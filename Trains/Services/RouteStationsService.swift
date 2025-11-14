import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias ThreadStationsResponse = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String, when date: String?) async throws -> ThreadStationsResponse
}

final class RouteStationsService: RouteStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getRouteStations(uid: String, when date: String? = nil) async throws -> ThreadStationsResponse {
        let response = try await client.getRouteStations(query: .init(
            uid: uid,
            date: date
        ))
        return try response.ok.body.json
    }
}
