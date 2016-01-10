//
//  DetailViewController.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    @IBOutlet weak var todoPhone: UITextField!
    
    var todo:TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todoItem.delegate = self
    
        if todo == nil {
            childButton.selected = true
            navigationController?.title = "Todo"
        }
        else {
            navigationController?.title = "Todo"
            if todo?.image == "child-selected"{
                childButton.selected = true
            }
            else if todo?.image == "phone-selected"{
                phoneButton.selected = true
            }
            else if todo?.image == "shopping-cart-selected"{
                shoppingCartButton.selected = true
            }
            else if todo?.image == "travel-selected"{
                travelButton.selected = true
            }
            
            todoItem.text = todo?.title
            todoPhone.text = todo?.clientPhone
            
            todoDate.setDate((todo?.date)!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // clear selected status
    func resetButtons() {
        childButton.selected = false
        phoneButton.selected = false
        shoppingCartButton.selected = false
        travelButton.selected = false
    }

    @IBAction func childTapped(sender: AnyObject) {
        resetButtons()
        childButton.selected = true
    }
    
    @IBAction func phoneTapped(sender: AnyObject) {
        resetButtons()
        phoneButton.selected = true
    }
    
    @IBAction func shoppingCartTapped(sender: AnyObject) {
        resetButtons()
        shoppingCartButton.selected = true
    }
    
    @IBAction func travelTapped(sender: AnyObject) {
        resetButtons()
        travelButton.selected = true
    }
    
    // Save the todo item
    @IBAction func okTapped(sender: AnyObject) {
        var image = ""
        if childButton.selected {
            image = "child-selected"
        }
        else if phoneButton.selected {
            image = "phone-selected"
        }
        else if shoppingCartButton.selected {
            image = "shopping-cart-selected"
        }
        else if travelButton.selected {
            image = "travel-selected"
        }
        
        if todo == nil {
            // New todo
            // let uuid = NSUUID.UUID().UUIDString
            let uuid = NSUUID().UUIDString // Spport Xcode 6.1
            print(todoDate.date)
            todo = TodoModel(id: uuid, image: image,
                title: todoItem.text!,
                clientName: todoItem.text!,
                clientPhone: todoPhone.text!,                
                date: todoDate.date)
            todos.append(todo!)
        }
        else {
            todo?.image = image
            todo?.title = todoItem.text!
            todo?.date = todoDate.date
            todo?.clientPhone = todoPhone.text!
            
            print(todoDate.date)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // Dismiss the keyboard
    // MARK: - Textfield
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   /*
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
*/
}
