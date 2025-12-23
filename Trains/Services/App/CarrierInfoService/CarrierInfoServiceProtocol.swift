typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String, system: String?) async throws -> CarrierResponse
}
