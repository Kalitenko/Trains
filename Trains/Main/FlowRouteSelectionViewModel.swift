import Combine
import SwiftUI
import Foundation

@MainActor
@Observable
final class FlowRouteSelectionViewModel {
    
    let settlements: [String] = [
        "Населенный пункт 1",
        "Населенный пункт 2",
        "Населенный пункт 3",
        "Населенный пункт 4",
        "Населенный пункт 5"
    ]
    
    let stations: [String] = [
        "Станция 1",
        "Станция 2",
        "Станция 3",
        "Станция 4",
        "Станция 5"
    ]
    
    var settlement: String = ""
    var station: String = ""
    
    let onFinish: (RoutePoint) -> Void
    
    init(onFinish: @escaping (RoutePoint) -> Void) {
        self.onFinish = onFinish
    }
    
    func selectSettlement(_ value: String) {
        settlement = value
    }
    
    func selectStation(_ value: String) {
        station = value
        finish()
    }
    
    private func finish() {
        let route = RoutePoint(
            settlement: settlement,
            station: station
        )
        onFinish(route)
    }
}
