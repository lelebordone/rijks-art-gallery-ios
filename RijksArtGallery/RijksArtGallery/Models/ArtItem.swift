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
    let elapsedMilliseconds, count: Int
    let artItemDetails: ArtItemDetails
    
    enum CodingKeys: String, CodingKey {
        case elapsedMilliseconds, count
        case artItemDetails = "artObject"
    }
}

// MARK: ArtObject
struct ArtItemDetails: ArtItem {
    let links: CollectionDetailsLink
    let priref, language: String
    let colors: [Color]
    let colorsWithNormalization: [ColorsWithNormalization]
    let normalizedColors, normalized32Colors: [Color]
    let titles: [String]
    let description: String
    let objectTypes, objectCollection: [String]
    let principalMakers: [PrincipalMaker]
    let plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker: String
    let acquisition: Acquisition
    let materials: [String]
    let dating: Dating
    let classification: Classification
    let historicalPersons: [String]
    let documentation: [String]
    let dimensions: [Dimension]
    let physicalMedium, subTitle, scLabelLine: String
    let label: Label
    let location: String
    
    // ArtItem
    let id, objectNumber, title: String
    let hasImage: Bool
    let principalOrFirstMaker, longTitle: String
    let showImage: Bool
    let webImage: Image
    let productionPlaces: [String]
}

// MARK: Acquisition
struct Acquisition: Decodable {
    let method, date, creditLine: String
}

// MARK: Classification
struct Classification: Decodable {
    let iconClassIdentifier: [String]
}

// MARK: Color
struct Color: Decodable {
    let percentage: Int
    let hex: String
}

// MARK: ColorsWithNormalization
struct ColorsWithNormalization: Decodable {
    let originalHex, normalizedHex: String
}

// MARK: Dating
struct Dating: Decodable {
    let presentingDate: String
    let sortingDate, period, yearEarly, yearLate: Int
}

// MARK: Dimension
struct Dimension: Decodable {
    let unit, type: String
    let value: String
}

// MARK: Label
struct Label: Decodable {
    let title, makerLine, labelDescription, notes, date: String

    enum CodingKeys: String, CodingKey {
        case title, makerLine
        case labelDescription = "description"
        case notes, date
    }
}

// MARK: CollectionDetailsLink
/// The [Collection Details API](https://data.rijksmuseum.nl/object-metadata/api/#collection-details-api) link of the art item
struct CollectionDetailsLink: Decodable {
    let search: String
}

// MARK: PrincipalMaker
struct PrincipalMaker: Decodable {
    let name, unFixedName, placeOfBirth, dateOfBirth: String
    let dateOfDeath: String
    let placeOfDeath: String
    let occupation, roles: [String]
    let nationality: String
    let productionPlaces: [String]
}
