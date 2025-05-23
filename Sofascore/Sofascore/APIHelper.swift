import Foundation
import UIKit

struct Helper{
    static let baseURL = URL(string: "https://sofa-ios-academy-43194eec0621.herokuapp.com")!
        
    enum Endpoint: String {
        case events = "/events"
        case secureEvents = "/secure/events"
        case login = "/login"
    }
    static func performRequest<T: Decodable>(
        endpoint: Endpoint,
        method: String,
        queryItems: [URLQueryItem] = [],
        requiresAuth: Bool,
        body: Data? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.rawValue), resolvingAgainstBaseURL: true) else {
            completion(.failure(HTTPError.invalidURL))
            return
        }
        
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(HTTPError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        if requiresAuth {
            guard let token = AuthService.shared.getToken() else {
                completion(.failure(HTTPError.unauthorized))
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }

    static func handleResponse<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        DispatchQueue.main.async {
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(HTTPError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(HTTPError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(HTTPError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(HTTPError.decodingFailed))
            }
        }
    }
}
