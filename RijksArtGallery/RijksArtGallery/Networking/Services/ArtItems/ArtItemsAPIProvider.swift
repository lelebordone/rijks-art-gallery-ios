import Foundation

enum ArtItemsAPIProvider {
    static func fetchArtItemsCollection(pageNumber: Int = 0,
                                        resultsPerPage: Int = 10,
                                        using culture: Culture = .nl,
                                        completion: @escaping (Result<CollectionNetworkResponse, NetworkError>) -> Void) {
        NetworkConfigurator().request(service: ArtItemsCollectionService(culture: culture,
                                                                         pageNumber: pageNumber,
                                                                         resultsPerPage: resultsPerPage)) { response in
            switch response {
            case .success(let result):
                completion(.success(result))
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
