struct RoutePoint {
    let settlement: String
    let station: String
    
    init(settlement: String, station: String) {
        self.settlement = settlement
        self.station = station
    }
    
    init() {
        self.settlement = ""
        self.station = ""
    }
}
