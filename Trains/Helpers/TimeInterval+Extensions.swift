import Foundation

extension TimeInterval {
    var hoursMinutesString: String {
        let totalMinutes = Int(self) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        switch (hours, minutes) {
        case (0, let m):
            return "\(m) мин"
        case (let h, 0):
            return "\(h) \(hourWord(h))"
        default:
            return "\(hours) \(hourWord(hours)) \(minutes) мин"
        }
    }
    
    private func hourWord(_ h: Int) -> String {
        switch h % 10 {
        case 1 where h % 100 != 11: return "час"
        case 2,3,4 where !(12...14).contains(h % 100): return "часа"
        default: return "часов"
        }
    }
}
