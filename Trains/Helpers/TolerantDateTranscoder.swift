import Foundation
import OpenAPIRuntime

struct TolerantDateTranscoder: DateTranscoder {
    
    func decode(_ string: String) throws -> Date {
        let isoNoFraction = ISO8601DateFormatter()
        isoNoFraction.formatOptions = [.withInternetDateTime]

        let isoWithFraction = ISO8601DateFormatter()
        isoWithFraction.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = isoNoFraction.date(from: string) { return date }
        if let date = isoWithFraction.date(from: string) { return date }
        if let date = timeFormatter.date(from: string) { return date }
        if let date = dateFormatter.date(from: string) { return date }

        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                codingPath: [],
                debugDescription: "Unsupported date format: \(string)"
            )
        )
    }
    
    func encode(_ date: Date) -> String {
        let isoNoFraction = ISO8601DateFormatter()
        isoNoFraction.formatOptions = [.withInternetDateTime]
        return isoNoFraction.string(from: date)
    }
}
