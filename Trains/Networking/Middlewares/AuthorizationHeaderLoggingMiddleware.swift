import Foundation
import OpenAPIRuntime
import HTTPTypes

struct AuthorizationHeaderLoggingMiddleware: ClientMiddleware {

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {

        Logger.debug("➡️ Запрос: \(request.method.rawValue) \(request.path ?? "")")
        if let authHeader = request.headerFields[.authorization] {
            Logger.debug("🔑 Authorization: \(authHeader)")
        }

        return try await next(request, body, baseURL)
    }
}
