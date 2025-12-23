import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

enum ScheduleServiceError: Error {
    case unexpectedStatusCode(Int)
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    
    // MARK: - Initializer
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, when date: String? = nil) async throws -> Segments {
        Logger.info("date: \(date ?? "no date")")
        do {
            let response = try await client.getScheduleBetweenStations(
                query: .init(
                    from: from,
                    to: to,
                    date: date
                )
            )
            
            switch response {
            case .ok(let okResponse):
                return try okResponse.body.json
            case .notFound(let notFoundResponse):
                Logger.info("Empty schedule for \(from) → \(to)")
                return try notFoundResponse.body.json
            case .undocumented(let statusCode, _):
                throw ScheduleServiceError.unexpectedStatusCode(statusCode)
            }
        }
    }
}
