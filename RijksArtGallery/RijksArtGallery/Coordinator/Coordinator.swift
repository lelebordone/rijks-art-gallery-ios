import UIKit

protocol Coordinator {
    associatedtype Route: RouteProtocol
    
    func push(_ route: Route, from viewController: UIViewController, animated: Bool)
    func present(_ route: Route, from viewController: UIViewController, animated: Bool)
    func create(_ route: Route) -> UIViewController
}
