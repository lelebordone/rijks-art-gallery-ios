import Foundation

enum APICollection {
    case rijksMuseum
    
    var domain: String {
        switch self {
        case .rijksMuseum:
            return "https://www.rijksmuseum.nl/api/"
        }
    }
}
