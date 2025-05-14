
import Foundation
import Network

enum APIClient {
        
    static func getGames(sport: SportSlug, completion: @escaping ([Event]) -> Void) {
        guard let token = AuthService.shared.getToken() else {
            completion([])
            return
        }
        
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/secure/events?sport=\(sport.rawValue)"
            guard let url = URL(string: urlString) else {
                completion([])
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let events = try? JSONDecoder().decode([Event].self, from: data) {
                completion(events)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}

extension APIClient {
    static func fetchSecureEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let token = AuthService.shared.getToken() else {
            completion(.failure(NSError(domain: "No token", code: 401, userInfo: [NSLocalizedDescriptionKey: "Niste prijavljeni"])))
            return
        }
        
        guard let url = URL(string: "https://sofa-ios-academy-43194eec0621.herokuapp.com/secure/events") else {
            completion(.failure(NSError(domain: "Neispravan URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Neispravan odgovor", code: 0)))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage: String
                switch httpResponse.statusCode {
                case 401: errorMessage = "Neautorizirani pristup"
                case 403: errorMessage = "Zabranjen pristup"
                case 404: errorMessage = "Resurs nije pronađen"
                default: errorMessage = "Server greška (\(httpResponse.statusCode))"
                }
                
                DispatchQueue.main.async {
                    completion(.failure(NSError(
                        domain: "HTTP Greška",
                        code: httpResponse.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: errorMessage]
                    )))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Nema podataka", code: 0)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970 
                let events = try decoder.decode([Event].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(events))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


