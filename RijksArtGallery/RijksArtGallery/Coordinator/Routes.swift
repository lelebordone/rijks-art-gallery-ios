import Foundation

protocol Route {}

enum ArtItemsRoute: Route {
    case artItemsCollection
    case artItemDetail(artItem: ArtItemDetails)
}
