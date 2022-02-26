import UIKit

extension UIViewController {
    func presentInFullScreenMode(_ viewControllerToPresent: UIViewController,
                                 animated: Bool = true,
                                 completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent,
                animated: animated,
                completion: completion)
    }
}
