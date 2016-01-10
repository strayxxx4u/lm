//
//  ViewController.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit



var todos: [TodoModel] = []
var filteredTodos: [TodoModel] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Calendar: FSCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view, typically from a nib.
      
        todos = [
            
            TodoModel(id: "1", image: "child-selected",
            title: "Аня",
            clientName: "Аня",
            clientPhone: "+7(985)876-90-09",
            date: dateFromString("2016-01-02 08:59:00")!),
            
            TodoModel(id: "2", image: "child-selected",
                title: "Оля",
                clientName: "Оля",
                clientPhone: "+7(985)876-90-09",
                date: dateFromString("2016-01-12 09:59:00")!),
            
            TodoModel(id: "3", image: "child-selected",
                title: "Лена",
                clientName: "Лена",
                clientPhone: "+7(985)876-90-09",
                date: dateFromString("2016-01-20 10:59:00")!),
            
            TodoModel(id: "4", image: "child-selected",
                title: "Настя",
                clientName: "Настя",
                clientPhone: "+7(985)876-90-09",
                date: dateFromString("2016-01-23 11:59:00")!),
            
            TodoModel(id: "5", image: "child-selected",
                title: "Женя",
                clientName: "Женя",
                clientPhone: "+7(985)876-90-09",
                date: dateFromString("2016-01-28 12:59:00")!),
            
            TodoModel(id: "6", image: "child-selected",
                title: "Маша",
                clientName: "Маша",
                clientPhone: "+7(985)876-90-09",
                date: dateFromString("2016-01-30 13:59:00")!)
            
        ]
      
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // hide the search bar
      //  var contentOffset = tableView.contentOffset
      //  contentOffset.y += searchDisplayController!.searchBar.frame.size.height
       // tableView.contentOffset = contentOffset
        
        //firstWeekday = 2;
        Calendar.firstWeekday = 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func compactCalendarTapped(sender: AnyObject) {
        Calendar.setScope(.Week, animated: true)
    }
    
    
    
    
    // MARK - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredTodos.count
        }
        else {
            return todos.count
        }
    }
    
    // Display the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Must use 'self' here because searchResultsTableView needs to reuse the same cell in self.tableView
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell")! as UITableViewCell
        var todo : TodoModel
        
        if tableView == searchDisplayController?.searchResultsTableView {
            todo = filteredTodos[indexPath.row] as TodoModel
        }
        else {
            todo = todos[indexPath.row] as TodoModel
        }

        let image = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        let date = cell.viewWithTag(103) as! UILabel
        let clientPhone = cell.viewWithTag(104) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        clientPhone.text = todo.clientPhone
        
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("HH:mm" , options:0, locale:locale)
        //yyyy-MM-dd HH:mm
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        date.text = dateFormatter.stringFromDate(todo.date)
        return cell

    }

    // MARK - UITableViewDelegate
    // Delete the cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
         Calendar.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // Edit mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    // Move the cell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    // MARK - UISearchDisplayDelegate
    // Search the Cell
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        //filteredTodos = todos.filter({( todo: TodoModel) -> Bool in
        //    let stringMatch = todo.title.rangeOfString(searchString)
        //    return stringMatch != nil
        //})
        
        // Same as below
        filteredTodos = todos.filter(){$0.clientPhone.rangeOfString(searchString!) != nil}
        return true
    }
    
    // MARK - Storyboard stuff
    // Unwind
    @IBAction func close(segue: UIStoryboardSegue) {
        print("closed!")
        tableView.reloadData()
        Calendar.reloadData()
        
    }
    
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            let vc = segue.destinationViewController as! DetailViewController
            // var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            let indexPath = tableView.indexPathForSelectedRow
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
    
    //============CALENDAR==============
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
        
     //   filteredTodos = todos.filter(){$0.date.rangeOfString(searchString!) != nil}

        
    }
    
    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        let calDateStr: String = stringFromDate(date)!
        
        for item in todos {
            
            if (stringFromDate(item.date)==calDateStr){
                return true
            }
        }
        
        return false
    }
    
    /*
    //Показываем картинку под датой !
    func calendar(calendar: FSCalendar!, imageForDate date: NSDate!) -> UIImage! {
        //todo = todos[indexPath.row] as TodoModel
        let calDateStr: String = stringFromDate(date)!
        
        for item in todos {
            
            if (stringFromDate(item.date)==calDateStr){
               return UIImage(named: "icon_cat")
            }
        }

        return nil
    }
    */
    
    
}

