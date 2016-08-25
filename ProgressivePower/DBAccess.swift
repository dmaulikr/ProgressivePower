//
//  DBAccess.swift
//  ProgressivePower
//
//  Created by Michael Lee on 8/24/16.
//  Copyright © 2016 ProgressivePower. All rights reserved.
//

import Foundation
import RealmSwift

class DBAccessManager{
    
    static func objectsForType <T: Object>(type : T.Type) -> Results<T>{
        let realm = try! Realm()
        return realm.objects(type)
    }
    
    static func filteredObjectsForType<T: Object>(type : T.Type, filterParam: NSString, filterString : NSString) -> Results<T>{
        let realm = try! Realm()
        return realm.objects(type).filter("\(filterParam) = '\(filterString)'")
    }
    
}