import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

final class LocalAllStationsService: AllStationsServiceProtocol {

    private let decoder = JSONDecoder()

    func getAllStations() async throws -> AllStations {
        guard let url = Bundle.main.url(
            forResource: "all_stations",
            withExtension: "json"
        ) else {
            throw LocalError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        return try decoder.decode(AllStations.self, from: data)
    }

    enum LocalError: Error {
        case fileNotFound
    }
}
