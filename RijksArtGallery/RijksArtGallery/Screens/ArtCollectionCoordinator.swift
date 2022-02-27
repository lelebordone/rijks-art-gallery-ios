import UIKit

struct ArtCollectionCoordinator: Coordinator {
    func create(_ route: ArtItemsRoute) -> UIViewController {
        switch route {
        case .artItemsCollection(let artItems):
            let viewModel = ArtItemsListViewModel(artItems: artItems)
            let vc = ArtItemsListViewController(viewModel: viewModel)
            
            let nav = UINavigationController.init(rootViewController: vc)
            nav.view.backgroundColor = UIColor.systemBackground
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.setBackgroundImage(nil, for: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.tintColor = .black
            
            return nav
        case .artItemDetail(let artItem):
            let viewModel = ArtItemDetailsViewModel(artItem: artItem)
            let vc = ArtItemDetailsViewController(viewModel: viewModel)
            
            return vc
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
