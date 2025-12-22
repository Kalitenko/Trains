struct RoutePoint {
    var settlement: String
    var station: StationItem
    
    init(settlement: String, station: StationItem) {
        self.settlement = settlement
        self.station = station
    }
    
    init() {
        self.settlement = ""
        self.station = StationItem(id: "", title: "")
    }
}
