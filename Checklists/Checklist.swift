//
//  Checklist.swift
//  Checklists
//
//  Created by sora on 14/11/9.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
    
    var items = [ChecklistItem]()
    var name = ""
}
