import Foundation

extension Date {
    var ISO8601DateString: String {
        DateFormatter.ISO8601Date.string(from: self)
    }
    
    func isBetween(startHour: Int, endHour: Int) -> Bool {
        let hour = Calendar.current.component(.hour, from: self)
        if startHour < endHour {
            return (hour >= startHour && hour < endHour)
        } else {
            return (hour >= startHour || hour < endHour)
        }
    }
}

private extension DateFormatter {
    static let ISO8601Date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
}

