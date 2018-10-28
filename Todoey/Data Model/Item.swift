//
//  Item.swift
//  Todoey
//
//  Created by alaa alrabi on 10/25/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title :String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated :Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "Items")
    
}
