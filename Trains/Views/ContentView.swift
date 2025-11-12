import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    private let apiKey: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStations()
            testFetchCopyright()
        }
    }
    
    func testFetchStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestStationsService(
                    client: client,
                    apikey: apiKey
                )
                
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = CopyrightService(
                    client: client,
                    apikey: apiKey
                )
                
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
