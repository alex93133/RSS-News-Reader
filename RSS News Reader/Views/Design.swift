import UIKit


class Design {
    
    //    Smooth reload data in TableView
    static func fadeReloadData(_ tableView: UITableView) {
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {tableView.reloadData()}, completion: nil)
    }
}
