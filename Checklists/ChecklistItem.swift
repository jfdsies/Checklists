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
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }

    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
}