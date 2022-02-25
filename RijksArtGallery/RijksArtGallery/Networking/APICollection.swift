import Foundation

enum APICollection {
    case rijksMuseum
    case mock
    
    var domain: String {
        switch self {
        case .rijksMuseum:
            return "https://www.rijksmuseum.nl/api/"
        case .mock:
            return "mock.domain"
        }
    }
}

enum Culture: String {
    case nl, en
}
