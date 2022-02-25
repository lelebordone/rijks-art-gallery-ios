import Foundation
@testable import RijksArtGallery

struct NetworkServiceMock: NetworkService {
    typealias ResponseModel = Data
    
    var api: APICollection { .mock }
    var path: String { "path/mock" }
    var jsonDecoder: DataDecoder { JSONDecoderMock() }
}
