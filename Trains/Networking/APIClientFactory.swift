import OpenAPIRuntime
import OpenAPIURLSession

enum APIClientFactory {
    
    // MARK: - Public Static Methods
    static func makeClient(apiKey: String) throws -> Client {
        let transport = URLSessionTransport()
        do {
            let serverURL = try Servers.Server1.url()
            
            return Client(
                serverURL: serverURL,
                configuration: Configuration(dateTranscoder: TolerantDateTranscoder()),
                transport: transport,
                middlewares: [
                    APIKeyAuthMiddleware(apiKey: apiKey),
                    AuthorizationHeaderLoggingMiddleware()
                ]
            )
        } catch {
            Logger.error("Invalid Server URL configuration: \(error)")
            throw AppError.apiConfigurationError(underlying: error)
        }
    }
    
    static func makeClient() -> Client {
        do {
            return try makeClient(apiKey: "3f70b170-ca9c-430c-9450-a75719fc6991")
        } catch {
            fatalError("Failed to create API Client: \(error)")
        }
    }
}
