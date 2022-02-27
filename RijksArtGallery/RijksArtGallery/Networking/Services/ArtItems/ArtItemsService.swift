import Foundation

struct ArtItemsCollectionService: NetworkService, RijksDataService {
    typealias ResponseModel = CollectionNetworkResponse
    
    var path: String { "\(culture)/collection" }
    var queryItems: QueryItems? {
        [RijksDataIDs.ParameterKeys.apiKey: api.key]
    }
    
    var culture: Culture
}

struct ArtItemsCollectionDetailsService: NetworkService, RijksDataService {
    typealias ResponseModel = CollectionDetailsNetworkResponse
    
    var path: String { "\(culture)/collection/\(objectNumber)" }
    var queryItems: QueryItems? {
        [RijksDataIDs.ParameterKeys.apiKey: api.key]
    }
    
    var culture: Culture
    var objectNumber: String
}
