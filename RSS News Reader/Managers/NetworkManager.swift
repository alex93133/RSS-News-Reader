import UIKit
import SwiftyXMLParser
import Alamofire


class NetworkManager{
    
    let urlString = "https://www.vesti.ru/vesti.rss"
    static let shared = NetworkManager()
    
    private init(){}
    
    
    func fetchXMLData(targetVC: UIViewController, handler: @escaping ([News]?) -> ()) {
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        AF.request(urlString).response { (response) in
            if let error = response.error {
                DispatchQueue.main.async {
                    AlertControllerManager.presentAllert(title: "Ошибка", message: error.errorDescription!, targetVC: targetVC, handler: nil)
                    return
                }
            }
            if let data = response.data {
                let parsedData = self.parseXMLData(from: data)
                DispatchQueue.main.async {
                    handler(parsedData)
                }
            }
        }
    }
    
    func parseXMLData (from data: Data) -> [News]? {
        let xml = XML.parse(data)
        let path = ["rss", "channel", "item"]
        let newsList = xml[path].map { News(title: $0["title"].text,
                                            pubDate: $0["pubDate"].text,
                                            category: $0["category"].text,
                                            fullText: $0["yandex:full-text"].text,
                                            imageURl: $0["enclosure"].attributes["url"])
        }
        return newsList
    }
}
