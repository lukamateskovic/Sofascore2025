
import Foundation
import Network

enum APIClient {
    
    static func getGames(sport: SportSlug, completion: @escaping ([Event]) -> Void){
        let urlString: String = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(sport.rawValue)"
        guard let url: URL = .init(string: urlString) else {
            completion([])
            return
        }
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data: Data,
               let container = try? JSONDecoder().decode([Event].self, from: data) {
                completion(container)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}
