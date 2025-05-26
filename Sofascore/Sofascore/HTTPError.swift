import UIKit

enum HTTPError: Int, LocalizedError {
    case invalidURL = 0
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case serverError = 500
    case invalidResponse = 1000
    case noData = 1001
    case decodingFailed = 1002
    case unknown = 9999
    
    init(statusCode: Int) {
        switch statusCode {
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 500: self = .serverError
        default: self = .unknown
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Neispravan URL"
        case .unauthorized: return "Neautorizirani pristup"
        case .forbidden: return "Zabranjen pristup"
        case .notFound: return "Resurs nije pronađen"
        case .serverError: return "Interna server greška"
        case .invalidResponse: return "Neispravan odgovor servera"
        case .noData: return "Nema podataka"
        case .decodingFailed: return "Greška u obradi podataka"
        case .unknown: return "Nepoznata greška"
        }
    }
}
