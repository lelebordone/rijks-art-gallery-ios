import Foundation

struct ArtItemListService: NetworkService {
    typealias ResponseModel = CollectionNetworkResponse
    
    var api: APICollection { .rijksMuseum }
    var path: String { "\(culture)/collection" }
    
    var culture: Culture
}
