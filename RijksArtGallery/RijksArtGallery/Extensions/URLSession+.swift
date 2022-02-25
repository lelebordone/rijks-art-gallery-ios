import Foundation

extension URLSession: NetworkSession {
    func loadData(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
}
