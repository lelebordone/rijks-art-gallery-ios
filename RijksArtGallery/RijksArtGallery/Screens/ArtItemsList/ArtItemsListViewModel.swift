import Foundation

class ArtItemsListViewModel {
    // MARK: - Properties
    var artItems: [ArtItemCompact] {
        didSet { updateSectionedDataSource(with: artItems) }
    }
    
    // Could be easily replaced by a simple array of tuples [(title: String, items: [ArtItemCompact])]
    private(set) var sectionedDataSource = [ArtItemsListCollectionViewSection]()
    
    // MARK: - Lifecycle
    init(artItems: [ArtItemCompact] = []) {
        self.artItems = artItems
    }
    
    // MARK: - Data fetching
    func fetchArtItemsCollection(with culture: Culture = .nl,
                                 completion: @escaping (Result<Void, NetworkError>) -> Void) {
        ArtItemsAPIProvider.fetchArtItemsCollection(with: culture) { result in
            switch result {
            case .success(let artItems):
                self.artItems = artItems
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
