import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    
    @State private var client: Client?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            if client == nil {
                client = APIClientFactory.makeClient()
            }
            let date = Date()
            let formattedDateString = date.ISO8601DateString
            //            testFetchStations()
            //            testFetchCopyright()
//            testFetchScheduleBetweenStations()
            //            testFetchScheduleBetweenStationsForDate(formattedDateString: formattedDateString)
            //            testFetchStationSchedule()
            //            testFetchStationScheduleForDate(formattedDateString: formattedDateString)
            //            testFetchRouteStations()
            //            testFetchRouteStationsForDate(formattedDateString: formattedDateString)
            //            testFetchNearestCity()
                        testFetchCarrierInfo()
                        testFetchCarrierInfoIATA()
            //                        testFetchAllStations()
        }
    }
    
    func testFetchStations() {
        Task {
            do {
                guard let client else { return }
                let service = NearestStationsService(client: client)
                
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
                guard let client else { return }
                let service = CopyrightService(client: client)
                
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    func testFetchScheduleBetweenStations() {
        Task {
            do {
                guard let client else { return }
                let service = ScheduleBetweenStationsService(client: client)
                
                print("Fetching schedule between stations...")
                let leningradskyMoscow = "s2006004"
                let moskovskySPB = "s9602494"
                let response = try await service.getScheduleBetweenStations(from: leningradskyMoscow, to: moskovskySPB)
                
                print("Successfully fetched schedule between stations: \(response)")
            } catch {
                print("Error fetching schedule between stations: \(error)")
            }
        }
    }
    
    func testFetchScheduleBetweenStationsForDate(formattedDateString: String) {
        Task {
            do {
                guard let client else { return }
                let service = ScheduleBetweenStationsService(client: client)
                
                print("Fetching schedule between stations...")
                let leningradskyMoscow = "s2006004"
                let moskovskySPB = "s9602494"
                
                let response = try await service.getScheduleBetweenStations(from: leningradskyMoscow, to: moskovskySPB, when: formattedDateString)
                
                print("Successfully fetched schedule between stations: \(response)")
            } catch {
                print("Error fetching schedule between stations: \(error)")
            }
        }
    }
    
    func testFetchStationSchedule() {
        Task {
            do {
                guard let client else { return }
                let service = StationScheduleService(client: client)
                
                print("Fetching station schedule...")
                let kaliningradBusStation = "s9623375"
                let response = try await service.getStationSchedule(station: kaliningradBusStation)
                
                print("Successfully fetched station schedule: \(response)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
    
    func testFetchStationScheduleForDate(formattedDateString: String) {
        Task {
            do {
                guard let client else { return }
                let service = StationScheduleService(client: client)
                
                print("Fetching station schedule...")
                let kaliningradBusStation = "s9623375"
                let response = try await service.getStationSchedule(station: kaliningradBusStation, when: formattedDateString)
                
                print("Successfully fetched station schedule: \(response)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
    
    func testFetchRouteStations() {
        Task {
            do {
                guard let client else { return }
                let service = RouteStationsService(client: client)
                
                print("Fetching route stations...")
                let uid = "770A_4_2"
                let response = try await service.getRouteStations(uid: uid)
                
                print("Successfully fetched route stations: \(response)")
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
    
    func testFetchRouteStationsForDate(formattedDateString: String) {
        Task {
            do {
                guard let client else { return }
                let service = RouteStationsService(client: client)
                
                print("Fetching route stations...")
                let uid = "770A_4_2"
                let response = try await service.getRouteStations(uid: uid, when: formattedDateString)
                
                print("Successfully fetched route stations: \(response)")
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
    
    func testFetchNearestCity() {
        Task {
            do {
                guard let client else { return }
                let service = NearestCityService(client: client)
                
                print("Fetching nearest city...")
                let response = try await service.getNearestCity(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched nearest city: \(response)")
            } catch {
                print("Error fetching nearest city: \(error)")
            }
        }
    }
    
    func testFetchCarrierInfo() {
        Task {
            do {
                guard let client else { return }
                let service = CarrierInfoService(client: client)
                
                let code = "4240" // РЖД/ДОСС
                
                print("Fetching carrier info...")
                let response = try await service.getCarrierInfo(
                    code: code
                )
                
                print("Successfully fetched carrier info: \(response)")
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
    
    func testFetchCarrierInfoIATA() {
        Task {
            do {
                guard let client else { return }
                let service = CarrierInfoService(client: client)
                
                let code = "SU" // Аэрофлот
                let system = "iata"
                
                print("Fetching carrier info...")
                let response = try await service.getCarrierInfo(
                    code: code,
                    system: system
                )
                
                print("Successfully fetched carrier info: \(response)")
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
    
    func testFetchAllStations() {
        Task {
            do {
                guard let client else { return }
                //                let service = AllStationsService(client: client)
                let service = LocalAllStationsService()
                
                print("Fetching all stations...")
                let response = try await service.getAllStations()
                let count = response.countries?
                    .flatMap { $0.regions ?? [] }
                    .flatMap { $0.settlements ?? [] }
                    .flatMap { $0.stations ?? [] }
                    .count ?? 0
                
                print("Successfully fetched all stations. There are \(count) stations in total.")
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
