import UIKit
import SnapKit

class AuthService {
    static let shared = AuthService()
    
    private var authURL: URL {
        Helper.baseURL.appendingPathComponent(Helper.Endpoint.login.rawValue)
    }
    private var secureEventsURL: URL {
        Helper.baseURL.appendingPathComponent(Helper.Endpoint.secureEvents.rawValue)
    }
    
    var currentUser: User? {
        didSet {
            NotificationCenter.default.post(name: .authStateChanged, object: nil)
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        var request = URLRequest(url: authURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = ["username": username, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            if let data = data {
                print("Response body:", String(data: data, encoding: .utf8) ?? "nil")
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NSError(domain: "LoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Server nije vratio podatke"])))
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                let user = User(name: authResponse.name)
                self.currentUser = user
                self.saveToken(authResponse.token)
                completion(.success(user))
            } catch {
                print("Decode error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    
    func logout() {
        CoreDataService.shared.deleteAllData()
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: "authToken")
    }
}

extension Notification.Name {
    static let authStateChanged = Notification.Name("authStateChanged")
}

