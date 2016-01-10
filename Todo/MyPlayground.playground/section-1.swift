// Playground - noun: a place where people can play

import UIKit

var dateString = "2016-01-01" // change to your date format

var dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
//"yyyy-MM-dd"


var date = dateFormatter.dateFromString(dateString)
print(date)


class TodoModel : NSObject{
    var id: String
    var image: String
    var title: String
    var clientName: String
    var clientPhone: String
    var date: NSDate
    
    init (id: String, image: String, title: String, clientName: String, clientPhone: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
        self.clientName = clientName
        self.clientPhone = clientPhone
    }
}

var todos = [
    TodoModel(id: "1", image: "child-selected", title: "1.", clientName: " Аня", clientPhone: " +79851311314", date: NSDate()),
    TodoModel(id: "2", image: "shopping-cart-selected", title: "2.", clientName: " Женя", clientPhone: " +79851311315", date: NSDate())]

// swap(&todos[sourceIndexPath.row], &todos[destinationIndexPath.row])


        
