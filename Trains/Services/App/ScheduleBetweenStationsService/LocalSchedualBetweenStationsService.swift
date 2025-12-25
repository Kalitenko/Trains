import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

enum LocalRoute: String {
    case simferopolMoscow
    case moscowKaraganda
    case moscowSaintPetersburg
    
    var fileName: String {
        switch self {
        case .simferopolMoscow: "from=c146&to=c213"
        case .moscowKaraganda: "from=c213&to=c164"
        case .moscowSaintPetersburg: "from=s2006004&to=s9602494&date=2025-12-20"
        }
    }
}

final class LocalScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let decoder = JSONDecoderFactory.tolerantDecoder()
    private let fileName: String
    
    // MARK: - Initializer
    init(fileName: String) {
        self.fileName = fileName
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, when date: String? = nil) async throws -> Segments {
        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "json"
        ) else {
            throw LocalError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(Segments.self, from: data)
    }
}
