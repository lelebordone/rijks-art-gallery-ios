import UIKit

struct ArtCollectionCoordinator: Coordinator {
    func create(_ route: ArtItemsRoute) -> UIViewController {
        switch route {
        case .artItemsCollection(let artItems):
            let homeViewModel = HomeViewModel(artItems: artItems)
            let homeVC = HomeViewController(viewModel: homeViewModel)
            
            let nav = UINavigationController.init(rootViewController: homeVC)
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.setBackgroundImage(nil, for: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.tintColor = .black
            
            return nav
        case .artItemDetail(_):
            return UIViewController()
        }
    }
    
    func push(_ route: ArtItemsRoute,
              from viewController: UIViewController,
              animated: Bool = true) {
        viewController.navigationController?.pushViewController(create(route),
                                                                animated: animated)
    }
    
    func present(_ route: ArtItemsRoute,
                 from viewController: UIViewController,
                 animated: Bool = true) {
        viewController.presentInFullScreenMode(create(route))
    }
}
