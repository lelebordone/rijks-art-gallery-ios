import Foundation

protocol NetworkSession {
    func loadData(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
