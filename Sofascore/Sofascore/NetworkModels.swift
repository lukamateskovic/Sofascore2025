import Foundation

public struct EventResponse: Decodable {
    public let events: [Event]
}

public struct Event: Decodable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: TimeInterval
    let status: Status
    let league: League
    let homeScore: Int?
    let awayScore: Int?
    
}

public struct Team: Decodable {
    let id: Int
    let name: String
    let logoUrl: URL
    
}

public struct League: Decodable {
    let id: Int
    let name: String
    let country: Country
    let logoUrl: URL?
    
}

public struct Country: Decodable {
    let id: Int
    let name: String
}

enum Status: String, Decodable {
    case finished = "FINISHED"
    case inProgress = "IN_PROGRESS"
    case notStarted = "NOT_STARTED"
}

public struct AuthResponse: Decodable {
    let token: String
    let name: String
}

public struct User: Decodable {
    let name: String
}

