import Foundation

struct ArtItemsCollectionService: NetworkService, RijksDataService {
    typealias ResponseModel = CollectionNetworkResponse
    
    var path: String { "\(culture)/collection" }
    var queryItems: QueryItems? {
        [RijksDataIDs.ParameterKeys.apiKey: api.key]
    }
    
    var culture: Culture
}
