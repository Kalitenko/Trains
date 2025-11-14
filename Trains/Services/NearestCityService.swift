import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias NearestCityResponse = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double, distance: Int?) async throws -> NearestCityResponse
}

final class NearestCityService: NearestCityServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getNearestCity(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCityResponse {
        let response = try await client.getNearestCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
