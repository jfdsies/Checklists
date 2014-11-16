//
//  ChecklistItem.swift
//  Checklists
//
//  Created by sora on 14/10/28.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemId: Int
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(itemId, forKey: "ItemId")
    }

    override init() {
        itemId = DataModel.nextChecklistItemId()
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemId = aDecoder.decodeIntegerForKey("ItemId")
        super.init()
    }
}