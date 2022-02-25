import Foundation
@testable import RijksArtGallery

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    init(data: Data? = nil,
         urlResponse: URLResponse? = nil,
         error: Error? = nil) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }
    
    func loadData(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, urlResponse, error)
    }
}
