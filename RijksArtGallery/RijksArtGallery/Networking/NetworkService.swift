import Foundation

protocol NetworkService {
    associatedtype ResponseModel: Decodable
    
    typealias QueryItems = [String: Any]
    
    /// The service's API. Its `domain` property will be automatically used as `baseURL` if the latter is not implemented.
    var api: APICollection { get }
    /// The base URL (i.e. `domain`) of the service
    var baseURL: String { get }
    var method: HTTPMethod { get }
    /// The path of the service. Combined with the baseURL you get the service's endpoint URL string
    var path: String { get }
    /// The query parameters of the service (e.g. `endpoint?key=value`)
    var queryItems: QueryItems? { get }
    /// The `Decoder` instance which will be used to decode the service's response data
    var jsonDecoder: DataDecoder { get }
}

extension NetworkService {
    var baseURL: String { api.domain }
    var method: HTTPMethod { .get }
    var queryItems: QueryItems? { nil }
    var jsonDecoder: DataDecoder { JSONDecoder() }
    
    /// The full endpoint URL string (i.e. `baseURL` + `path`)
    var endpointURLString: String { baseURL + path }
}

protocol DataDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
