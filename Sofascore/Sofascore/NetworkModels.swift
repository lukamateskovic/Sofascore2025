import Foundation

public struct Standing: Decodable {
    let team: Team
    let position: Int32
    let matches: Int32
    let wins: Int32
    let losses: Int32
    let draws: Int32
    let points: Int32?
    let percentage: Double?
    let scoreFor: Int32?
    let scoreAgainst: Int32?
    let scoreFormatted: String?           
    
    var goalDifference: String {
        guard let scoreFor = scoreFor, let scoreAgainst = scoreAgainst else {
            return "-"
        }
        let diff = scoreFor - scoreAgainst
        return diff >= 0 ? "+\(diff)" : "\(diff)"
    }
    
    var goals: String {
        guard let scoreFor = scoreFor, let scoreAgainst = scoreAgainst else {
            return scoreFormatted ?? "-:-"
        }
        return "\(scoreFor):\(scoreAgainst)"
    }
    
    var displayPoints: String {
        return "\(points ?? 0)"
    }
}

public struct Event: Decodable {
    let id: Int64
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int64
    let status: Status
    let league: League
    let homeScore: Int32?
    let awayScore: Int32?
    let round: Int32?
    let incidents: [Incident]?
}

public struct Team: Decodable {
    let id: Int32
    let name: String
    let logoUrl: String
    let country: Country?
}

public struct League: Decodable {
    let id: Int32
    let name: String
    let country: Country
    let logoUrl: String
    let seasonId: Int64?
}

public struct Country: Decodable {
    let name: String
}

public struct Incident: Decodable {
    let type: IncidentType
    let minute: Int32
    let isHomeTeam: Bool?
    let extraMinute: Int32?
    let player: String?
    let scoreDiff: Int32?
    let score: String?
    let description: String?
}

enum Status: String, Decodable {
    case finished = "FINISHED"
    case inProgress = "IN_PROGRESS"
    case notStarted = "NOT_STARTED"
    case halfTime = "HALF_TIME"
}

public enum IncidentType: String, Decodable {
    case goal = "GOAL"
    case redCard = "RED_CARD"
    case yellowCard = "YELLOW_CARD"
    case periodEnd = "PERIOD_END"
    case foul = "FOUL"
}

public struct AuthResponse: Decodable {
    let name: String
    let token: String
}

public struct User: Decodable {
    let name: String
}

public struct TeamInfoResponse: Decodable {
    let team: TeamDetail
    let manager: TeamManager?
    let venue: TeamVenue?
}

public struct TeamDetail: Decodable {
    let id: Int64
    let name: String
    let logoUrl: String
    let country: Country
}

public struct TeamManager: Decodable {
    let id: Int64
    let name: String
    let country: Country
    let imageUrl: String?
}

public struct TeamVenue: Decodable {
    let name: String
    let capacity: Int32?
    let city: TeamVenueCity?
}

public struct TeamVenueCity: Decodable {
    let name: String
}

public struct TeamPlayer: Decodable {
    let id: Int64
    let name: String
    let shortName: String?
    let position: String?
    let jerseyNumber: String?
    let country: Country
    let imageUrl: String?
    let isForeign: Bool?
}

public struct TeamTournament: Decodable {
    let id: Int64
    let name: String
    let logoUrl: String
    let seasonId: Int64?
}
