typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol: Sendable {
    func getCarrierInfo(code: String, system: String?) async throws -> CarrierResponse
}
