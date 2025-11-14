import Foundation

extension Date {
    var ISO8601DateString: String {
        DateFormatter.ISO8601Date.string(from: self)
    }
}

private extension DateFormatter {
    static let ISO8601Date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
}

