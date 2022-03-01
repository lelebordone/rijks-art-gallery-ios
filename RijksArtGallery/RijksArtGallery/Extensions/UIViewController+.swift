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
    
    func presentCancelAlertController(title: String,
                                      message: String,
                                      buttonTitle: String = "Ok",
                                      cancelTitle: String = "Cancel",
                                      handler: ((UIAlertAction) -> Void)? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let preferredAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        ac.addAction(preferredAction)
        ac.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        ac.preferredAction = preferredAction
        
        self.present(ac, animated: true)
    }
    
    func presentAlertController(title: String,
                                message: String,
                                buttonTitle: String = "Ok",
                                handler: ((UIAlertAction) -> Void)? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        
        self.present(ac, animated: true)
    }
    
    func presentAlertController(error: UserFacingError,
                                buttonTitle: String = "Ok",
                                handler: ((UIAlertAction) -> Void)? = nil) {
        presentAlertController(title: error.message,
                               message: error.description,
                               buttonTitle: buttonTitle,
                               handler: handler)
    }
}
