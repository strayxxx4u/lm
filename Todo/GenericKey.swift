//
//  GenericKey.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import Foundation

public class GenericKey: BaseKey {
    
    public var value: NSString?
    
    private var secretData: NSData? {
        
        return value?.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Initializers
    ///////////////////////////////////////////////////////
    
    public init(keyName: String, value: NSString? = nil) {
        
        self.value = value
        super.init(name: keyName)
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - KeychainItem
    ///////////////////////////////////////////////////////
    
    public override func makeQueryForKeychain(keychain: KeychainService) -> KeychainQuery {
        
        let query = KeychainQuery(keychain: keychain)
        
        query.addField(kSecClass, withValue: kSecClassGenericPassword)
        query.addField(kSecAttrService, withValue: keychain.serviceName)
        query.addField(kSecAttrAccount, withValue: name)
        
        return query
    }
    
    public override func fieldsToLock() -> [NSObject: AnyObject] {
        
        var fields = [NSObject: AnyObject]()
        
        if let data = secretData {
            
            fields[kSecValueData as String] = data
        }
        
        return fields
    }
    
    public override func unlockData(data: NSData) {
        
        value = NSString(data: data, encoding: NSUTF8StringEncoding)
    }
}
