import Foundation

extension URLRequest {
    init?<Service: NetworkService>(service: Service) {
        guard
            let urlComponents = URLComponents(service: service),
            let url = urlComponents.url
        else { return nil }
        
        self.init(url: url)
        
        httpMethod = service.method.rawValue
    }
}
