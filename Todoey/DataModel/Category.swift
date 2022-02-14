//
//  Category.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 13/02/2022.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
