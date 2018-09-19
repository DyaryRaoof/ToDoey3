//
//  Categories.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/18/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String  = ""
    
    let items = List<Item>()
}
