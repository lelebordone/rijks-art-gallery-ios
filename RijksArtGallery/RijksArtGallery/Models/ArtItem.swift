import Foundation

// MARK: - Art Item
protocol ArtItem: Decodable {
    var id: String { get }
    /// Number of the art item. This is used in the [Collection Details API](https://data.rijksmuseum.nl/object-metadata/api/#collection-details-api) to get an item's details (i.e. `objectNumber`).
    var objectNumber: String { get }
    var title: String { get }
    /// Boolean flag that indicates whether the art item's image is available or not.
    var hasImage: Bool { get }
    /// Name of the main or first maker of the art item.
    var principalOrFirstMaker: String { get }
    var longTitle: String { get }
    var showImage: Bool { get }
    var webImage: Image { get }
    /// List of the places where the art item has been made / worked on.
    var productionPlaces: [String] { get }
}

// MARK: - Collections
// MARK: Collection API network response
// TODO: think about how to abstract it, in order to have just one generic response model
struct CollectionNetworkResponse: Decodable {
    let elapsedMilliseconds, count: Int
    let artItems: [ArtItemCompact]
    
    enum CodingKeys: String, CodingKey {
        case elapsedMilliseconds, count
        case artItems = "artObjects"
    }
}

// MARK: ArtObject
struct ArtItemCompact: ArtItem {
    let permitDownload: Bool
    let headerImage: Image
    
    // ArtItem
    let id, objectNumber, title: String
    let links: Links
    let hasImage: Bool
    let principalOrFirstMaker, longTitle: String
    let showImage: Bool
    let webImage: Image
    let productionPlaces: [String]
}

// MARK:  Image
struct Image: Decodable {
    let guid: String
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String
}

// MARK: Links
/// The web and [Collection Details API](https://data.rijksmuseum.nl/object-metadata/api/#collection-details-api) links of the art item
struct Links: Decodable {
    let linksSelf, web: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case web
    }
}

// MARK: - Collection Details
// MARK: Collection Details API network response
struct CollectionDetailsNetworkResponse: Decodable {
    let elapsedMilliseconds: Int
    let artItemDetails: ArtItemDetails
    
    enum CodingKeys: String, CodingKey {
        case elapsedMilliseconds
        case artItemDetails = "artObject"
    }
}

// MARK: ArtObject
struct ArtItemDetails: ArtItem {
    let colors: [Color]
    let description: String
    let principalMakers: [PrincipalMaker]
    let materials: [String]
    let dating: Dating
    let physicalMedium, subTitle: String
    let location: String
    
    // ArtItem
    let id, objectNumber, title: String
    let hasImage: Bool
    let principalOrFirstMaker, longTitle: String
    let showImage: Bool
    let webImage: Image
    let productionPlaces: [String]
}

// MARK: Color
struct Color: Decodable {
    let percentage: Int
    let hex: String
}

// MARK: Dating
struct Dating: Decodable {
    let presentingDate: String
    let sortingDate, period, yearEarly, yearLate: Int
}

// MARK: PrincipalMaker
struct PrincipalMaker: Decodable {
    let name: String
}

// MARK: Helper methods
extension ArtItemDetails {
    enum ArtItemDetailsLabels: CaseIterable {
        case dating, artists, materials, medium, productionPlaces
        
        var title: String {
            switch self {
            case .dating:
                return "When"
            case .artists:
                return "Artists"
            case .materials:
                return "Materials"
            case .medium:
                return "Medium"
            case .productionPlaces:
                return "Production places"
            }
        }
    }
    
    var principalMakersNames: [String] { principalMakers.map { $0.name } }
    var principalMakersLabel: String {
        guard !principalMakersNames.isEmpty else { return "N/A" }
        
        return principalMakersNames.joined(separator: ", ")
    }
    
    var materialsLabel: String {
        guard !materials.isEmpty else { return "N/A" }
        return materials.joined(separator: ", ")
    }
    
    var productionPlacesLabel: String {
        guard !productionPlaces.isEmpty else { return "N/A" }
        return productionPlaces.joined(separator: ", ")
    }
}
