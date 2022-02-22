import Foundation

protocol NetworkService {
    associatedtype ResponseModel: Codable
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var jsonBody: [String: Any]? { get }
    
    var endpointURLString: String { get }
}
