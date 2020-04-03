import UIKit


class AlertControllerManager {
    
    static func presentAllert (title: String, message: String, closeButton: String = "Закрыть", targetVC : UIViewController, handler: ((UIAlertAction) -> ())? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAlert = UIAlertAction(title: closeButton, style: .cancel, handler: handler)
        alert.addAction(closeAlert)
        targetVC.present(alert, animated: true, completion: nil)
    }
}
