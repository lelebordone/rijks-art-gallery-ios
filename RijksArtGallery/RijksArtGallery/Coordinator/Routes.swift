import Foundation

protocol RouteProtocol {}

enum ArtItemsRoute: RouteProtocol {
    case artItemsCollection(artItems: [ArtItemCompact] = [])
    case artItemDetail(artItem: ArtItemDetails)
}
