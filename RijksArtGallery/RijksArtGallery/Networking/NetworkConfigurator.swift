import Foundation

struct NetworkConfigurator {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<Service: NetworkService>(service: Service,
                                          completion: @escaping (Result<Service.ResponseModel, NetworkError>) -> Void) {
        guard let request = URLRequest(service: service) else {
            completion(.failure(NetworkError.invalidEndpoint))
            return
        }
        
        #if DEBUG
        print("REQUEST: \(service)")
        #endif
        
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(NetworkError.generic(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse()))
                    return
                }
                
                switch response.statusCode {
                case 200...299:
                    guard let data = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    
                    #if DEBUG
                    print("RESPONSE: \(String(decoding: data, as: UTF8.self))")
                    #endif
                    
                    do {
                        let responseModel = try service.jsonDecoder.decode(Service.ResponseModel.self, from: data)
                        completion(.success(responseModel))
                    } catch {
                        completion(.failure(NetworkError.decoding))
                    }
                default:
                    completion(.failure(NetworkError.invalidResponse(statusCode: response.statusCode)))
                }
            }
        }.resume()
    }
}
