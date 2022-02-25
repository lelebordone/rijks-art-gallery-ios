import Foundation

protocol RijksDataService {
    var api: APICollection { get }
}

extension RijksDataService {
    var api: APICollection { .rijksMuseum }
}
