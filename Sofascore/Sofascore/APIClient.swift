import Foundation
import Network
import UIKit

enum APIClient{
    
    static func getGames(sport: SportSlug, completion: @escaping (Result<[Event], Error>) -> Void) {
        let queryItems = [URLQueryItem(name: "sport", value: sport.rawValue)]
        Helper.performRequest(
            endpoint: .events,
            method: "GET",
            queryItems: queryItems,
            requiresAuth: false,
            completion: completion
        )
    }
    
    static func fetchSecureEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        Helper.performRequest(
            endpoint: .secureEvents,
            method: "GET",
            requiresAuth: true,
            completion: completion
        )
    }
}

