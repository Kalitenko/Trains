import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String, system: String?) async throws -> CarrierResponse
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getCarrierInfo(code: String, system: String? = nil) async throws -> CarrierResponse {
        let response = try await client.getCarrierInfo(query: .init(
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
