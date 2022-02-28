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
    
    var key: String {
        switch self {
        case .rijksMuseum:
            return "0fiuZFh4"
        case .mock:
            return "mock.key"
        }
    }
}

enum RijksDataIDs {
    enum ParameterKeys {
        static let apiKey = "key"
        static let pageNumber = "p"
        static let resultsPerPage = "ps"
    }
}

enum Culture: String {
    case nl, en
}
