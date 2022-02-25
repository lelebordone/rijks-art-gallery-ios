import Foundation

struct ArtItemsCollectionService: NetworkService {
    typealias ResponseModel = CollectionNetworkResponse
    
    var api: APICollection { .rijksMuseum }
    var path: String { "\(culture)/collection" }
    
    var culture: Culture
}
