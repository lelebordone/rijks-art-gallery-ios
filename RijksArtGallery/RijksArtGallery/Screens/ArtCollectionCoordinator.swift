import UIKit

struct ArtCollectionCoordinator: Coordinator {
    func create(_ route: ArtItemsRoute) -> UIViewController {
        switch route {
        case .artItemsCollection(let artItems):
            let homeViewModel = ArtItemsListViewModel(artItems: artItems)
            let homeVC = ArtItemsListViewController(viewModel: homeViewModel)
            
            let nav = UINavigationController.init(rootViewController: homeVC)
            nav.view.backgroundColor = UIColor.systemBackground
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
