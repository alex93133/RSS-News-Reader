import UIKit
import DropDown


class NewsFeedViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var newsData: [News]? {
        didSet {
            newsList = newsData!
        }
    }
    var newsList = [News]()
    var selectedNews: News?
    var currentCategory = "Все"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customNavigationBarTitle()
    }
    
    private func setupView() {
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl?.backgroundColor =  UIColor(named: "darkColor")!
        refreshControl?.tintColor = UIColor(named: "blueColor")!
        tableView.tableFooterView = UIView()
    }
    
    private func customNavigationBarTitle() {
        navigationItem.title = "Vesti.ru"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor(named: "blueColor")!]
    }
    
    private func getData() {
        NetworkManager.shared.fetchXMLData(targetVC: self) { [weak self] (parsedData) in
            guard parsedData != nil else { return }
            self?.newsData = parsedData
            self?.showNewsByCategory(category: self!.currentCategory)
            Design.fadeReloadData(self!.tableView)
            self!.refreshControl?.endRefreshing()
        }
    }
    
    private func createDropDownMenu() -> DropDown {
        let dropDown = DropDown()
        dropDown.anchorView = menuButton
        let arrayOfCategories = newsData!.map { $0.category! }
        var uniqueCategories = Array(Set(arrayOfCategories))
        uniqueCategories.insert("Все", at: 0)
        dropDown.dataSource = uniqueCategories
        return dropDown
    }
    
    private func showNewsByCategory(category: String) {
        newsList = newsData!
        if category != "Все" {
            newsList.removeAll { $0.category != category }
        }
        Design.fadeReloadData(tableView)
    }
    
    @objc func refresh(sender:AnyObject) {
        refreshControl?.beginRefreshing()
        getData()
    }
    
    
    @IBAction func dropDownMenu(_ sender: UIBarButtonItem) {
        guard newsData != nil else { return }
        let dropDownMenu = createDropDownMenu()
        dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.currentCategory = item
            self.showNewsByCategory(category: item)
        }
        dropDownMenu.show()
    }
}
