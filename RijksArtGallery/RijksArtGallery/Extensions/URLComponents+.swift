import Foundation

extension URLComponents {
    init?<Service: NetworkService>(service: Service) {
        self.init(string: service.endpointURLString)
        
        queryItems = service.queryItems?.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
