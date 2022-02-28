import Foundation

class ArtItemsListViewModel {
    // MARK: - Properties
    var artItems: [ArtItemCompact] {
        didSet { updateSectionedDataSource(with: artItems) }
    }
    
    // Could be easily replaced by a simple array of tuples [(title: String, items: [ArtItemCompact])]
    private(set) var sectionedDataSource = [ArtItemsListCollectionViewSection]()
    
    var pageNumber: Int
    var resultsPerPage: Int
    
    // MARK: - Lifecycle
    init(artItems: [ArtItemCompact] = [],
         pageNumber: Int = 0,
         resultsPerPage: Int = 10) {
        self.artItems = artItems
        self.pageNumber = pageNumber
        self.resultsPerPage = resultsPerPage
    }
    
    // MARK: - Data fetching
    func fetchArtItemsCollection(using culture: Culture = .nl,
                                 completion: @escaping (Result<Void, NetworkError>) -> Void) {
        ArtItemsAPIProvider.fetchArtItemsCollection(pageNumber: pageNumber,
                                                    resultsPerPage: resultsPerPage,
                                                    using: culture) { result in
            switch result {
            case .success(let artItems):
                self.artItems = artItems
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchArtItemDetails(with objectNumber: String,
                             using culture: Culture = .nl,
                             completion: @escaping (Result<ArtItemDetails, NetworkError>) -> Void) {
        ArtItemsAPIProvider.fetchArtItemDetails(with: objectNumber, using: culture, completion: completion)
    }
    
    // MARK: - Data source handling
    func updateSectionedDataSource(with artItems: [ArtItemCompact]) {
        // Grouping the items by their main artist in a simple dictionary
        let artItemsGroupedByArtist = Dictionary(grouping: artItems) { $0.principalOrFirstMaker }
        
        // Mapping and sorting the dictionary to an array of sections (i.e. `ArtItemsListCollectionViewSection`)
        sectionedDataSource = artItemsGroupedByArtist.map { artist, items in
            ArtItemsListCollectionViewSection(title: artist,
                                              items: items.sorted { $0.title < $1.title })
        }.sorted { $0.title < $1.title }
    }
}
