//
//  registrationViewController.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import RealmSwift

class registrationViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        userEmail.delegate = self
        userPassword.delegate = self
        phoneNumber.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        if (userName.text == "" || userEmail.text == "" || userPassword.text == "" || phoneNumber.text == "")
        {
           errorTextField.text = "Все поля должны быть заполнены!"
           errorTextField.hidden = false
        }
        
        else
        {
            
            //////////Проверка корректности введенных данных на сервере////////////
            //https://lashmakers.pro/registerUser.php
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(phoneNumber.text, forKey: "phoneNumber")
            defaults.synchronize()
            
            let secretCode  = Int(arc4random() % 10000)

            
            Alamofire.request(.GET, "https://lashmakers.pro/registerUser.php", parameters: ["userName": userName.text!, "userPassword": userPassword.text!, "userEmail": userEmail.text!, "phoneNumber": phoneNumber.text!, "secretCode":secretCode])
                .responseJSON { response in
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    if let JSONres = response.result.value {
                        print("JSON: \(JSONres)")
                        
                        let requestStatus:String = ""
                        //response.result["status"] as! String
                        
                        
                        if requestStatus == "300" {
                            //Запомним телефонный номер
                           let requestSecretCode:String = ""
                            //JSONres["secretCode"] as! String
                            
                            let kInfoTitle = "Проверка"
                            let kSubtitle = "На Ваш номер телефона отправлено СМС сообщение с кодом подтверждения."
                            
                            let alert = SCLAlertView()
                            let txt = alert.addTextField("Введите полученный код")
                            alert.addButton("Подтвердить") {
                                if requestSecretCode == txt.text {
                                    
                                    ////////////////////////////РЕГИСТРАЦИЯ/////////////////////////////
                                    //Так как пользователь выбрал режим работы Мастер, 
                                    //необходимо настроить БД для этого режима работы 
                                    //и заблокировать функции режима Студия для использования
                                    ////////////////////////////////////////////////////////////////////
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let MainView = storyboard.instantiateViewControllerWithIdentifier("mainContrallerID")
                                    
                                    self.navigationController?.pushViewController(MainView, animated: true)
                                    self.navigationController?.navigationBarHidden = false
                                }
                            }
                            alert.showCloseButton = false
                            alert.showEdit(kInfoTitle, subTitle:kSubtitle)

                        }
                        
                        if requestStatus == "400" {
                            self.errorTextField.text!  = "Неверное имя пользователя или пароль!"
                            self.errorTextField.hidden = false
                            
                        }
                        
                        
                    }
            }
            
            
            ///////////////////////////////////////////////////////////////////////
            
        }
        
    }

    
    

    @IBAction func checkPhoneNumber(sender: UITextField) {
        
        if phoneNumber.touchInside && phoneNumber.text!.isEmpty {
            phoneNumber.text = "+7"
            
        }
        
        if  !phoneNumber.text!.isEmpty {
        
        
        
            if phoneNumber.text!.characters.count == 2 {
                phoneNumber.text = phoneNumber.text! + "("
            }
            if phoneNumber.text?.characters.count == 6 {
                phoneNumber.text = phoneNumber.text! + ")"
            }
            if phoneNumber.text?.characters.count == 10 || phoneNumber.text?.characters.count == 13 {
                phoneNumber.text = phoneNumber.text! + "-"
            }
            if phoneNumber.text?.characters.count > 16 {
                let seqString = phoneNumber.text!.characters.dropLast()
                phoneNumber.text? = String(seqString)
            }
        
        }
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
