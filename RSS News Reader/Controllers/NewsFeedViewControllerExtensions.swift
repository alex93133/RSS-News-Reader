import UIKit
import DropDown


//MARK:  TableView Delegate, DataSource
extension NewsFeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.isEmpty ? 0 : newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewsFeedCustomCell
        let news = newsList[indexPath.row]
        cell.titleLabel.text = news.title
        cell.dateLabel.text = news.attributedDate
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNews = newsList[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc   = segue.destination as? SelectedNewsViewController else { return }
        dvc.selectedNews = selectedNews
    }
}



