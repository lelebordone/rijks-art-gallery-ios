import Foundation

class HomeViewModel {
    // MARK: - Properties
    private var artItems: [ArtItemCompact]
    
    // MARK: - Lifecycle
    init(artItems: [ArtItemCompact] = []) {
        self.artItems = artItems
    }
    
    // MARK: - Data fetching
    func fetchArtItems(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        // TODO: add data fetching logic
    }
}
