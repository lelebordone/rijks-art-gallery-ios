import Foundation
@testable import RijksArtGallery

struct JSONDecoderMock: DataDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let data = data as? T {
            return data
        } else {
            throw NetworkError.decoding
        }
    }
}
