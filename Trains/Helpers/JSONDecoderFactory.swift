import Foundation

enum JSONDecoderFactory {
    static func tolerantDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            
            if let date = ISO8601DateFormatter().date(from: string) {
                return date
            }
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            timeFormatter.timeZone = .current
            if let date = timeFormatter.date(from: string) {
                return date
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = .current
            if let date = dateFormatter.date(from: string) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date format: \(string)"
            )
        }
        return decoder
    }
}
