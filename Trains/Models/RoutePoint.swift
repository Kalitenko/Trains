struct RoutePoint {
    let settlement: String
    let station: StationItem
    
    init(settlement: String, station: StationItem) {
        self.settlement = settlement
        self.station = station
    }
}
extension RoutePoint {
    func withSettlement(_ settlement: String) -> RoutePoint {
        RoutePoint(
            settlement: settlement,
            station: station
        )
    }
    
    func withStation(_ station: StationItem) -> RoutePoint {
        RoutePoint(
            settlement: settlement,
            station: station
        )
    }
    static let empty = RoutePoint(
        settlement: "",
        station: StationItem(id: "", title: "")
    )
}
