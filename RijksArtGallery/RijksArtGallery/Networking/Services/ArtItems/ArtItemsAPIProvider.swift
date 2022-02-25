import Foundation

enum ArtItemsAPIProvider {
    static func fetchArtItemsCollection(with culture: Culture,
                                        completion: @escaping (Result<[ArtItemCompact], NetworkError>) -> Void) {
        NetworkConfigurator().request(service: ArtItemsCollectionService(culture: culture)) { response in
            switch response {
            case .success(let result):
                completion(.success(result.artItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
