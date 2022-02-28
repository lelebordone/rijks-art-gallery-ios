import Foundation

protocol RouteProtocol {}

enum ArtItemsRoute: RouteProtocol {
    case artItemsCollection(artItems: [ArtItemCompact] = [],
                            resultsPerPage: Int = 10)
    case artItemDetail(artItem: ArtItemDetails)
}
