import UIKit


//MARK:  TableView Delegate, DataSource
extension SelectedNewsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell") as! NewsPosterCustomCell
            if let url = selectedNews.imageURl {
                cell.activityIndicator.startAnimating()
                cell.newsPoster.imageFromServerURL(urlString: url, defaultImage: nil) { cell.activityIndicator.stopAnimating() }
                cell.newsPoster.contentMode = .scaleAspectFill
            } else {
                cell.newsPoster.isHidden = true
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! NewsTitleCustomCell
            cell.newsTitle.text = selectedNews.title
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell")!
            cell.textLabel?.text = selectedNews.fullText
            cell.textLabel?.textColor = UIColor(named: "whiteColor")!
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
}
