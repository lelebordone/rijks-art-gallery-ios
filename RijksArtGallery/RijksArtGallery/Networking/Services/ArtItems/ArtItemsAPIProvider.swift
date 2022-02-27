import Foundation

enum ArtItemsAPIProvider {
    static func fetchArtItemsCollection(using culture: Culture = .nl,
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
    
    static func fetchArtItemDetails(with objectNumber: String,
                                    using culture: Culture = .nl,
                                    completion: @escaping (Result<ArtItemDetails, NetworkError>) -> Void) {
        NetworkConfigurator().request(service: ArtItemsCollectionDetailsService(culture: culture,
                                                                                objectNumber: objectNumber)) { response in
            switch response {
            case .success(let result):
                completion(.success(result.artItemDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
