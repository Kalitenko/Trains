import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

enum LocalCarrier: String {
    case aeroflot
    case rzd
    case turkishAirlines
    
    var fileName: String {
        switch self {
        case .aeroflot: "Aeroflot"
        case .rzd: "RZD"
        case .turkishAirlines: "Turkish Airlines"
        }
    }
}

final class LocalCarrierInfoService: CarrierInfoServiceProtocol {
    
    // MARK: - Private Properties
    private let decoder = JSONDecoderFactory.tolerantDecoder()
    private let fileName: String
    
    // MARK: - Initializer
    init(fileName: String) {
        self.fileName = fileName
    }
    
    // MARK: - Public Methods
    func getCarrierInfo(code: String, system: String? = nil) async throws -> CarrierResponse {
        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "json"
        ) else {
            throw LocalError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(CarrierResponse.self, from: data)
    }
}
