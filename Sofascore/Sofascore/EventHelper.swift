import UIKit
import SofaAcademic

struct EventHelper {
    static func formatStartTime(for event: Event) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    static func getTimeDescription(for event: Event) -> String {
        switch event.status {
        case .finished:
            return "FT"
        case .inProgress:
            let currentDateTime = Date()
            let startDate = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
            let minutesPassed = Int((currentDateTime.timeIntervalSince(startDate)) / 60)
            return "\(minutesPassed)'"
        default:
            return "-"
        }
    }

    static func getTimeColor(for event: Event) -> UIColor {
        switch event.status {
        case .inProgress:
            return .systemRed
        default:
            return .gray
        }
    }

    static func getScoreColor(for event: Event, isHomeTeam: Bool) -> UIColor {
        switch event.status {
        case .finished:
            if isHomeTeam {
                if event.homeScore ?? 0 > event.awayScore ?? 0 {
                    return .black
                } else {
                    return .gray
                }
            } else {
                if event.awayScore ?? 0 > event.homeScore ?? 0 {
                    return .black
                } else {
                    return .gray
                }
            }
        case .inProgress:
            return .systemRed
        default:
            return .black
        }
    }

    static func getTeamColor(for event: Event, isHomeTeam: Bool) -> UIColor {
        switch event.status {
        case .finished:
            if isHomeTeam {
                if event.homeScore ?? 0 > event.awayScore ?? 0 {
                    return .black
                } else {
                    return .gray
                }
            } else {
                if event.awayScore ?? 0 > event.homeScore ?? 0 {
                    return .black
                } else {
                    return .gray
                }
            }
        default:
            return .black
        }
    }
}
