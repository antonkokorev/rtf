import SwiftUI

func getMonth(num:String, full:Bool = false) -> String{
    var result:String = ""
    switch num {
        case "01":
            result = "январь"
        case "02":
             result = "февраль"
        case "03":
             result = "март"
        case "04":
             result = "апрель"
        case "05":
             result = "май"
        case "06":
             result = "июнь"
        case "07":
             result = "июль"
        case "08":
             result = "август"
        case "09":
             result = "сентябрь"
        case "10":
             result = "октябрь"
        case "11":
             result = "ноябрь"
        case "12":
             result = "декабрь"
        default:
             result = "косяк"
        }
    return (full) ? result : String(result.prefix(3))
}
func getData(date:Int64, format:String) -> String{
    
 let dateTimeStamp = Date(timeIntervalSince1970: TimeInterval(date) / 1000)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier: "ru")
    dateFormatter.dateFormat = format
     return dateFormatter.string(from: dateTimeStamp)
  
}
