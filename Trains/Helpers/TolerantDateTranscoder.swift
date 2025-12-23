import Foundation
import OpenAPIRuntime

struct TolerantDateTranscoder: OpenAPIRuntime.DateTranscoder {
    
    private static let isoFormatterNoFraction: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f
    }()
    
    private static let isoFormatterWithFraction: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss"
        f.timeZone = .current
        return f
    }()
    
    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        f.timeZone = .current
        return f
    }()
    
    func decode(_ string: String) throws -> Date {
        if let date = Self.isoFormatterNoFraction.date(from: string) {
            return date
        }
        if let date = Self.isoFormatterWithFraction.date(from: string) {
            return date
        }
        if let date = Self.timeFormatter.date(from: string) {
            return date
        }
        if let date = Self.dateFormatter.date(from: string) {
            return date
        }
        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                codingPath: [],
                debugDescription: "Unsupported date format: \(string)"
            )
        )
    }
    
    func encode(_ date: Date) -> String {
        Self.isoFormatterNoFraction.string(from: date)
    }
}
