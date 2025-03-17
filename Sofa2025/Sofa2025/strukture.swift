import Foundation

struct LeagueModel {
    let countryName: String
    let leagueName: String
    let leagueLogoUrl: String
}

struct MatchModel {
    let startTime: String
    let homeTeamName: String
    let homeTeamLogoUrl: String
    let awayTeamName: String
    let awayTeamLogoUrl: String
    let homeScore: Int?
    let awayScore: Int?
}
