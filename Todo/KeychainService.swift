//
//  KeychainService.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//

import Foundation

public protocol KeychainService {
    
    var accessMode: NSString {get}
    var serviceName: String {get}
    var accessGroup: String? {get set}
    
    func add(key: KeychainItem) -> NSError?
    func update(key: KeychainItem) -> NSError?
    func remove(key: KeychainItem) -> NSError?
    func get<T: BaseKey>(key: T) -> (item: T?, error: NSError?)
}
