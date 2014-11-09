//
//  Checklist.swift
//  Checklists
//
//  Created by sora on 14/11/9.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    init(name: String) {
        self.name = name
        super.init()
    }
    
    var items = [ChecklistItem]()
    var name = ""
}
