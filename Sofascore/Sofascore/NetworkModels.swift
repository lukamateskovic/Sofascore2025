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





//import Foundation
//
//struct GameResponse: Codable {
//    let data: [Game]
//    let meta: Meta
//}
//
//struct Game: Codable {
//    let id: String
//    let sportSlug: String
//    let date: Date
//    let homeTeam: Team
//    let awayTeam: Team
//    let scores: Scores
//    let tournament: Tournament
//    
//    enum CodingKeys: String, CodingKey {
//        case id, date, homeTeam, awayTeam, scores, tournament
//        case sportSlug = "sport_slug"
//    }
//}
//
//struct Team: Codable {
//    let id: String
//    let name: String
//    let logo: URL?
//}
//
//struct Scores: Codable {
//    let home: Int?
//    let away: Int?
//}
//
//struct Tournament: Codable {
//    let id: String
//    let name: String
//    let country: Country
//}
//
//struct Country: Codable {
//    let name: String
//    let code: String
//}
//
//struct Meta: Codable {
//    let currentPage: Int
//    let totalPages: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case currentPage = "current_page"
//        case totalPages = "total_pages"
//    }
//}
