//
//  Item.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/18/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
