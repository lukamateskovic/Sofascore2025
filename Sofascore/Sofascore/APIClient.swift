import Foundation
import Network
import UIKit

enum APIClient{
    
    static func fetchSecureEvents(sport: SportSlug, completion: @escaping (Result<[Event], Error>) -> Void) {
        let queryItems = [URLQueryItem(name: "sport", value: sport.rawValue)]
        Helper.performRequest(
            endpoint: .events,
            method: "GET",
            queryItems: queryItems,
            requiresAuth: true,
            completion: completion
        )
    }
    
    static func fetchIncidents(eventId: Int64, completion: @escaping (Result<[Incident], Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.incidents.rawValue, eventId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
                
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    static func fetchLeagueMatches(leagueId: Int64, completion: @escaping (Result<[Event], Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.matches.rawValue, leagueId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    static func fetchLeagueStandings(leagueId: Int64, completion: @escaping (Result<[Standing], Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.league.rawValue, leagueId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    static func fetchTeamDetails(teamId: Int64, completion: @escaping (Result<TeamInfoResponse, Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.teams.rawValue, teamId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    static func fetchTeamPlayers(teamId: Int64, completion: @escaping (Result<[TeamPlayer], Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.players.rawValue, teamId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    static func fetchTeamTournaments(teamId: Int64, completion: @escaping (Result<[TeamTournament], Error>) -> Void) {
        let endpoint = String(format: Helper.Endpoint.tournaments.rawValue, teamId)
        let url = Helper.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = AuthService.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            Helper.handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }

}

