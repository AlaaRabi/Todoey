//
//  Category.swift
//  Todoey
//
//  Created by alaa alrabi on 10/25/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let Items = List<Item>() 
}
