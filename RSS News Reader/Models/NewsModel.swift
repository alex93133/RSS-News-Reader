import Foundation


//MARK: News
struct News {
    let title: String?
    let pubDate: String?
    let category: String?
    let fullText: String?
    let imageURl: String?
    
    var attributedDate: String {
        get {
            let removedDots = pubDate!.replacingOccurrences(of: ",", with: "")
            let splitWords = removedDots.split(separator: " ")
            let monthDictionary = ["Jan" : "01", "Feb" : "02", "Mar" : "03", "Apr" : "04", "May" : "05", "Jun" : "06", "Jul" : "07", "Aug" : "08", "Sep" : "09", "Oct" : "10", "Nov" : "11", "Dec" : "12",]
            let time = splitWords[4].dropLast(3)
            
            let date = Date()
            let calendar = Calendar.current
            let currentDayNumber = calendar.component(.day, from: date)
            
            let date_: String
            if currentDayNumber == Int(splitWords[1]) {
                date_ = "сегодня"
            } else  {
                date_ = splitWords[1] + "." + monthDictionary["\(splitWords[2])"]! + "." + splitWords[3]
            }
            let attributedDate = time + " " + date_
            return attributedDate
        }
    }
}
