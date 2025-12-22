import Foundation

struct Carrier: Hashable {
    let carrierName: String
    let departure: Date
    let arrival: Date
    let duration: TimeInterval
    let connectingStation: String?
    let imageURL: URL?
}
extension Carrier {
    var startTime: String { DateFormatter.time.string(from: departure) }
    var finishTime: String { DateFormatter.time.string(from: arrival) }
    var date: String { DateFormatter.dayMonth.string(from: departure) }
    var durationText: String { duration.hoursMinutesString }
    var hasTransfer: Bool { connectingStation != nil }
}
