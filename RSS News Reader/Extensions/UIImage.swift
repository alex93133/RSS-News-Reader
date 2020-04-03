import UIKit


extension UIImageView {
    func imageFromServerURL(urlString: String, defaultImage : String?, handler: @escaping () -> ()) {
        if let di = defaultImage {
            self.image = UIImage(named: di)
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                return
            }
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }).resume()
        handler()
    }
}

