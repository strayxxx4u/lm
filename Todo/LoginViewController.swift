//
//  LoginViewController.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import UIKit
import LocalAuthentication
import Alamofire
import RealmSwift



class LoginViewController: UIViewController, UITextFieldDelegate {
   
    let keychain = Keychain()
    
    @IBOutlet weak var loginName: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    @IBOutlet weak var logInSavePassSwitch: UISwitch!
    @IBOutlet weak var masterButton: UIButton!
    @IBOutlet weak var razdelitelLabel: UILabel!
    @IBOutlet weak var studioButton: UIButton!
    
    ///////////////////////BEGIN Touch ID/////////////////////////
    
    func showPasswordAlert()
    {
        let alertController = UIAlertController(title: "Touch ID Password", message: "Пожалуйста, введите пароль.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Cancel) { (action) -> Void in
            
            if let textField = alertController.textFields?.first as UITextField?
            {
                if textField.text == "123"
                {
                    print("Authentication successful! :) ")
                }
                else
                {
                    self.showPasswordAlert()
                }
            }
        }
        alertController.addAction(defaultAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
            textField.placeholder = "Password"
            textField.secureTextEntry = true
            
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func authenticateUser()
    {
        let context = LAContext()
        var error: NSError?
        let reasonString = "Для входа необходимо авторизоваться!"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                
                if success
                {
                    print("Authentication successful! :) ")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let MainView = storyboard.instantiateViewControllerWithIdentifier("mainContrallerID")
                    
                    self.navigationController?.pushViewController(MainView, animated: true)
                    
                }
                else
                {
                    switch policyError!.code
                    {
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system.")
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user.")
                        
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter password.")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    default:
                        print("Authentication failed! :(")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    }
                }
                
            })
        }
        else
        {
            print(error?.localizedDescription)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.showPasswordAlert()
            })
        }
    }
    
    
    //////////////////////END Touch ID/////////////////////////////

    ///////////////////////BEGIN Keychain/////////////////////////
    
    private func printGenericKey(key: GenericKey) {
        
        if let passcode = keychain.get(key).item?.value {
            
            print("\(key.name) value: [\(passcode)]")
            
        } else {
            
            print("can't find the [\(key.name)] key in the keychain")
        }
    }
    
    
    //////////////////////END Keychain/////////////////////////////
    
  func passSwitchIsON()
  {
    //Необходимо понимание того, был ли включен переключатель в положение ON ранее,
    //так как, если был, тогда нужно обновлять keychain данные, а не добавлять
    //если, попытаться добавить данные, а они уже были до этого добавлены, произойдет ошибка
    
    //Получение настроек переключателя:
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let passSwitch = defaults.integerForKey("PassSwitch") //получили значение переключателя
    
    if passSwitch == 1 { //Переключатель был ранее установлен в положение ON, необходимо не добавлять а обновлять keychain
        
        //Обновление данных
        let keyName = "passcode"
        let updateKey = GenericKey(keyName: keyName, value: passwordUser.text)
        if let error = keychain.update(updateKey) {
            
            print("error updating the passcode key \(error)")
            
        } else {
            
            print(">> updated the passcode key")
        }
        
    }
    
    if passSwitch != 1 { //Переключатель не был ранее установлен в положение ON, необходимо добавлять keychain
        
        //Сохранение данных
        let keyName = "passcode"
        let key = GenericKey(keyName: keyName, value: passwordUser.text)
        
        if let error = keychain.add(key) {
            
            print("error adding the passcode key \(error)")
            
        } else {
            
            print(">> added the passcode key")
        }
        
        printGenericKey(key)
    }
    
    //Сохранение настроек:
    defaults.setInteger(1, forKey: "PassSwitch")
    defaults.setValue(loginName.text, forKey: "UserName")
    defaults.synchronize()

    }
 //=================================================================================
     override func viewDidLoad() {
        super.viewDidLoad()
        
        print("UDID \(UIApplication.udID())")
        print("aDID \(UIApplication.adID())")
        print("Random UDID \(UIApplication.uuID())")
        
        print("bundleId \(UIApplication.bundleId())")
        print("bundleId \(UIApplication.bundleName())")
        print("bundleId \(UIApplication.appVersion())")
        print("bundleId \(UIApplication.appBuild())")
        
        loginName.delegate = self
        passwordUser.delegate = self

        
        let defaults = NSUserDefaults.standardUserDefaults()
        let passSwitch = defaults.integerForKey("PassSwitch") //получили значение переключателя
        
        if passSwitch == 1 {
            logInSavePassSwitch.on = true
            loginName.text = defaults.objectForKey("UserName") as? String
            let keyName = "passcode"
            let key = GenericKey(keyName: keyName)
            if let passcode = keychain.get(key).item?.value {
                
                passwordUser.text = passcode as String
                
            } else {
                
                print("can't find the [\(key.name)] key in the keychain")
            }
            
        }
       // self.authenticateUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if loginName.text != "" && passwordUser.text != "" {
            // Not Empty, Do something.
            
            if logInSavePassSwitch.on {
                //Переключатель сохранения пароля в положении ON
                
                passSwitchIsON()
   
                
            } else {
                // If the user has selected NO to saving password
                //Обнуление данных:
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setInteger(0, forKey: "PassSwitch")
                defaults.setValue("", forKey: "UserName")
                defaults.synchronize()
            }
            
            //////////Проверка корректности введенных данных на сервере////////////
            //https://lashmakers.pro/registerUser.php
            
            Alamofire.request(.GET, "https://lashmakers.pro/registerUser.php", parameters: ["userName": loginName.text!, "userPassword": passwordUser.text!])
                .responseJSON { response in
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON["status"] as! String)")
                        
                        let requestStatus:String = JSON["status"] as! String
                        
                        if requestStatus == "300" {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //let MainView = storyboard.instantiateViewControllerWithIdentifier("mainContrallerID")
                            let MainView = storyboard.instantiateViewControllerWithIdentifier("newMainViewControllerID")
                            
                            
                            self.navigationController?.pushViewController(MainView, animated: true)
                            self.navigationController?.navigationBarHidden = true
                        }
                        
                        if requestStatus == "400" {
                            self.errorTextField.text!  = "Неверное имя пользователя или пароль!" 
                            self.errorTextField.hidden = false

                        }
                        
                        
                    }
            }
            
            
            ///////////////////////////////////////////////////////////////////////
            
            
      
            
        } else {
            // Empty, Notify user
            self.errorTextField.text!  = "Имя пользователя и пароль должны быть заполнены!"
            self.errorTextField.hidden = false
        }
        
       
        
    }
    
    
    @IBAction func RegistrationButtonTapped(sender: AnyObject) {
      
        print("registration select type")
        
        masterButton.hidden = false
        razdelitelLabel.hidden = false
        studioButton.hidden = false
        
    }
    
    
    
    @IBAction func masterRegistrationTapped(sender: AnyObject) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainView = storyboard.instantiateViewControllerWithIdentifier("masterRegistrationControllerID")
        
        self.navigationController?.pushViewController(MainView, animated: true)
        //self.navigationController?.navigationBarHidden = false
        
 
        
    }
    

    @IBAction func studioRegistrationTapped(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainView = storyboard.instantiateViewControllerWithIdentifier("studioRegistrationControllerID")
        
        self.navigationController?.pushViewController(MainView, animated: true)
        //self.navigationController?.navigationBarHidden = false
        
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //loginName.resignFirstResponder()
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
