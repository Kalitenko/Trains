import OpenAPIRuntime
import OpenAPIURLSession

enum APIClientFactory {
    
    // MARK: - Public Static Methods
    static func makeClient(apiKey: String) -> Client {
        let transport = URLSessionTransport()
        return Client(
            serverURL: try! Servers.Server1.url(),
            transport: transport,
            middlewares: [
                APIKeyAuthMiddleware(apiKey: apiKey),
                AuthorizationHeaderLoggingMiddleware()
            ]
        )
    }
    
    static func makeClient() -> Client {
        makeClient(apiKey: "")
    }
}
