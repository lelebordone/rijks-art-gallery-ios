import Foundation

class HomeViewModel {
    // MARK: - Properties
    private var artItems: [ArtItemCompact]
    
    // MARK: - Lifecycle
    init(artItems: [ArtItemCompact] = []) {
        self.artItems = artItems
    }
    
    // MARK: - Data fetching
    func fetchArtItemsCollection(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        ArtItemsAPIProvider.fetchArtItemsCollection(with: .en) { result in
            switch result {
            case .success(let artItems):
                self.artItems = artItems
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
