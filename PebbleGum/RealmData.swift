//
//  RealmData.swift
//  PebbleGum
//
//  Created by Anthony Da Mota on 14/02/15.
//  Copyright (c) 2015 GoodGuysLabs. All rights reserved.
//

import Foundation
import Realm

class Credential: RLMObject {
    dynamic var credentialId = 0
    dynamic var credentialTitle = ""
    dynamic var credentialEmail = ""
    dynamic var credentialPassword = ""
    dynamic var credentialNotes = ""
    dynamic var category: Category? // category is optional
    
    override class func primaryKey() -> String! {
        return "credentialId"
    }
}

class Category: RLMObject {
    dynamic var categoryName = ""
    dynamic var categoryIcon = ""
    
    override class func primaryKey() -> String! {
        return "categoryName"
    }
}