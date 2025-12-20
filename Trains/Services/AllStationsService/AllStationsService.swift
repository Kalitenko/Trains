import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

final class AllStationsService: AllStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let decoder = JSONDecoder()
    private let limit = 50 * 1024 * 1024 // 50Mb
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())
        
        let responseBody = try response.ok.body.html
        
        var fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try decoder.decode(AllStations.self, from: fullData)
        
        return allStations
    }
}
