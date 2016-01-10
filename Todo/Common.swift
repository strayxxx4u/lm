//
//  Common.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import Foundation
import AdSupport

/*
extension String {
    subscript(index: Int) -> Character {
        get {
            return self[advancedBy(self.startIndex, index)]
        }
    }
}
*/

func getIntKeyFromString (key: String) -> Int {
    
    
    let indexFirst = key.startIndex//.advancedBy(1)
    let indexLast  = key.startIndex.advancedBy(1)
    
    if key[indexFirst] == "0" && key[indexLast] == "0" {
        return 0
    }
    
    if key[indexFirst] == "0" && key[indexLast] != "0" {
        
        return Int(String(key[indexLast]))!
    }
    
    
    if key[indexFirst] != "0" {
        
        var keyStr: String = ""
        
        keyStr += String(key[indexFirst])
        keyStr += String(key[indexLast])
        return Int(keyStr)!
    }
    
    
  //  print("startIndex \(key[indexFirst]) indexLast \(key[indexLast])" )
    return 99
}

func getRandomNumberBetween (From: Int , To: Int) -> Int {
    return From + Int(arc4random_uniform(UInt32(To - From + 1)))
}


func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}



func dateFromString (dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}


func stringFromDate (date: NSDate) -> String? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let datestr = dateFormatter.stringFromDate(date)
    return datestr
}

func stringFromDateShort (date: NSDate) -> String? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH-mm"
    let datestr = dateFormatter.stringFromDate(date)
    return datestr
}

extension UIApplication {
    class func udID() -> NSString {
        return UIDevice.currentDevice().identifierForVendor!.UUIDString
    }
    
    class func adID() -> String {
        return ASIdentifierManager.sharedManager().advertisingIdentifier!.UUIDString
    }
    
    class func uuID() -> String {
        return NSUUID().UUIDString
    }
    
    class func bundleId() -> NSString {
        return NSBundle.mainBundle().infoDictionary![kCFBundleIdentifierKey as String] as! String
    }
    
    class func bundleName() -> String {
        return NSBundle.mainBundle().infoDictionary![kCFBundleNameKey as String] as! String
    }
    
    class func appVersion() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    }
    
    class func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    // Returns TRUE if user is on less than iOS 8, otherwise it performs the check
    class func isUserRegisteredForRemoteNotifications() -> Bool {
        
            return UIApplication.sharedApplication().isRegisteredForRemoteNotifications()
    
    }
}
