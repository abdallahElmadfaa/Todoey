//
//  Item.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 13/02/2022.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType : Category.self , property : "items")
    
}
