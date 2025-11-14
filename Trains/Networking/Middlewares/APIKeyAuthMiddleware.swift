import Foundation
import OpenAPIRuntime
import HTTPTypes

struct APIKeyAuthMiddleware: ClientMiddleware {
    
    // MARK: - Private Properties
    private let apiKey: String
    
    // MARK: - Initializer
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = "\(apiKey)"
        return try await next(request, body, baseURL)
    }
}
