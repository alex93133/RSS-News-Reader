import UIKit


class SelectedNewsViewController: UITableViewController {
    
    var selectedNews: News!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
