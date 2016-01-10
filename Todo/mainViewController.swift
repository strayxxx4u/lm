//
//  mainViewController.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private var hourItems = [dayRecord]()
private var dayItems = [[dayRecord]](count: 24, repeatedValue: hourItems)

class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDataSource, FSCalendarDelegate, UICollectionViewDelegateFlowLayout  {

    var itemCountInSection: [Int] = []
    var itemTimesNames: [String] = []
    var itemClientNames: [String] = []
    var itemClientPhones: [String] = []
    //itemCountInSection = [0, 0, 1, 0, 2, 0, 0, 3, 0, 4, 0, 0,2,0,0,0,0]
    
    //itemTimesNames = ["07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
    
    
    @IBOutlet weak var Calendar: FSCalendar!
    @IBOutlet weak var timelineView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Calendar.layer.borderColor = UIColorFromRGB(0xffffff).CGColor
   /*
        class dayRecord : NSObject {
            var name: String = ""
            var phone: String = ""
            var master: String = ""
            var date: NSDate = NSDate()
            var price: Int = 0
            var key: String = ""
        }
        
*/

        
        
        var newItem = dayRecord()
        newItem.name = "Аня"
        newItem.phone = "+7(985)876-90-09"
        newItem.master = "Олеся"
        newItem.date = dateFromString("2016-01-02 08:10:00")!
        newItem.price = 0
        newItem.key = "08"
        hourItems.append(newItem)

        newItem = dayRecord()
        
        newItem.name = "Александра"
        newItem.phone = "+7(495)980-48-49"
        newItem.master = "Света"
        newItem.date = dateFromString("2016-01-02 08:20:00")!
        newItem.price = 3500
        newItem.key = "08"
        hourItems.append(newItem)
        
        dayItems.insert(hourItems, atIndex: 8)
        
        hourItems = []
    
        newItem = dayRecord()
        
        newItem.name = "Оля"
        newItem.phone = "+7(913)321-44-21"
        newItem.master = "Света"
        newItem.date = dateFromString("2016-01-02 11:30:00")!
        newItem.price = 0
        newItem.key = "11"
        hourItems.append(newItem)
        
        dayItems.insert(hourItems, atIndex: 11)
        
        
        
        for item in dayItems {
            if item.count != 0 {
                print("Key \(item[0].key) count \(item.count)")
                itemCountInSection.append(item.count)
                itemTimesNames.append("\(item[0].key):00")
            }
        }

        
        itemClientNames = ["Александра", "Женя" , "Катя", "Марина", "Света"]
        itemClientPhones = ["+7(985)132-34-56", "+7(913)132-33-51" , "+7(904)456-34-77", "+7(981)678-43-90", "+7(913)410-10-10"]
        
        
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
        
        Calendar.firstWeekday = 2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func addTapped(sender: AnyObject) {
        
       
        
    }
    
    
    @IBAction func deleteTapped(sender: AnyObject) {
    /*
        for item in timelineView!.visibleCells() {
            
            var indexPath : NSIndexPath = timelineView!.indexPathForCell(item)!
             print("Section for delete \(indexPath.section) row \(indexPath.row)")
            
            var cell  = timelineView!.cellForItemAtIndexPath(indexPath)
            
            
            //Profile Picture
            //var img : UIImageView = cell.viewWithTag(100) as UIImageView
            //img.image = UIImage(named: "q.png") as UIImage
            
            //Close Button
            var deleteButton : UIButton = cell!.viewWithTag(666) as! UIButton
            deleteButton.hidden = false
        }

       */
    }
    
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // return the number of sections
        
        return itemCountInSection.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemCountInSection[section]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        print("Section for request \(indexPath.section) row \(indexPath.row)")
        print(itemTimesNames[indexPath.section])
        let keyRecord: Int = getIntKeyFromString(itemTimesNames[indexPath.section])
        print(keyRecord)
        let currentItem = dayItems[keyRecord][indexPath.row]

        
        
        // Configure the cell
        if let imageView = cell.viewWithTag(10) as? UIImageView{
            
            let Number1 = Int(arc4random_uniform(UInt32(2)))
            let Number2 = Int(arc4random_uniform(UInt32(10)))
            let imageName = "\(Number1)\(Number2).png"
            imageView.image = UIImage(named: imageName)
            //круглим картинку
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            
        }
        
        if let clientName = cell.viewWithTag(222) as? UILabel{
            //clientName.text = itemClientNames[indexPath.row]
            clientName.text = currentItem.name
        }

        if let clientPhone = cell.viewWithTag(223) as? UILabel{
            //clientPhone.text = itemClientPhones[indexPath.row]
              clientPhone.text = currentItem.phone
        }
 
        if let clientTime = cell.viewWithTag(224) as? UILabel{
            //clientPhone.text = itemClientPhones[indexPath.row]
            clientTime.text = stringFromDateShort(currentItem.date)
        }

        if let clientPrice = cell.viewWithTag(225) as? UILabel{
            //clientPhone.text = itemClientPhones[indexPath.row]
            clientPrice.text = "\(currentItem.price) руб."
        }
 
        
        let deleteButton : UIButton = cell.viewWithTag(666) as! UIButton
        deleteButton.layer.setValue(indexPath, forKey: "index")
        deleteButton.addTarget(self, action: "deletePhoto:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        cell.layer.cornerRadius = 20
        //print("Section \(indexPath.section) row \(indexPath.row)")
        return cell
    }
    
    func deletePhoto(sender:UIButton) {
        let indexPath : NSIndexPath = (sender.layer.valueForKey("index")) as! NSIndexPath
        //Albums.removeAtIndex(i)
        print("Tapped delete button section \(indexPath.section) row \(indexPath.row)")
        timelineView!.deleteItemsAtIndexPaths([indexPath])
        timelineView!.reloadData()
    }

    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView: UICollectionReusableView
        if kind == UICollectionElementKindSectionHeader{
            supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath)
            if let textLabel = supplementaryView.viewWithTag(10) as? UILabel{
                textLabel.text = itemTimesNames[indexPath.section]
                }
        }
        else{
            supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath)
        }
        
        return supplementaryView
    }
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == itemCountInSection.count - 1{
            return CGSize(width: 20, height: 2)
        }else{
            return CGSizeZero
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
           // performSegueWithIdentifier("showDetail", sender: cell)
            if let clientName = cell.viewWithTag(222) as? UILabel{
                print(clientName.text)
            }
            
            if let clientPhone = cell.viewWithTag(223) as? UILabel{
                print(clientPhone.text)
            }
            
            let deleteButton : UIButton = cell.viewWithTag(666) as! UIButton
            deleteButton.hidden = false

        } else {
            // Error indexPath is not on screen: this should never happen.
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            let deleteButton : UIButton = cell.viewWithTag(666) as! UIButton
            deleteButton.hidden = true
            
        }
    }
    
    //============CALENDAR==============
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
        
       //При смене даты необходимо перезаполнить массивы для генерации timeview
        
        //1. получим структуру записай для этого дня
        
        
        
     //   itemCountInSection = [ 1, 2, 3, 4, 2]
     // itemTimesNames = ["09:00", "11:00", "14:00", "19:00", "21:00"]
        itemClientNames = ["Александра", "Женя" , "Катя", "Марина", "Света"]
        itemClientPhones = ["+7(985)132-34-56", "+7(913)132-33-51" , "+7(904)456-34-77", "+7(981)678-43-90", "+7(913)410-10-10"]
        
        
        timelineView.reloadData()
        
        self.title = "222222222222"
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


}
