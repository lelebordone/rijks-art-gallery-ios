import Foundation

protocol NetworkService {
    associatedtype ResponseModel: Codable
    
    typealias QueryParameters = [String: Any]
    
    /// The service's API
    var api: APICollection { get }
    /// The base URL (i.e. `domain`) of the service
    var baseURL: String { get }
    var method: HTTPMethod { get }
    /// The path of the service. Combined with the baseURL you get the service's endpoint URL string
    var path: String { get }
    /// The query parameters of the service (e.g. `endpoint?key=value`)
    var queryParameters: QueryParameters? { get }
    
}

extension NetworkService {
    var baseURL: String { api.domain }
    var method: HTTPMethod { .get }
    var queryParameter: QueryParameters? { nil }
    
    /// The full endpoint URL string (i.e. `baseURL` + `path`)
    var endpointURLString: String { baseURL + path }
}
