//
//  ChecklistItem.swift
//  Checklists
//
//  Created by sora on 14/10/28.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}