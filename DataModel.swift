//
//  DataModel.swift
//  Checklists
//
//  Created by sora on 11/11/14.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
        }
    }
    
    class func nextChecklistItemId() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemId = userDefaults.integerForKey("ChecklistItemId")
        userDefaults.setInteger(itemId + 1, forKey: "ChecklistItemId")
        userDefaults.synchronize()
        return itemId
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.setBool(false, forKey: "FirstTime")
        }
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1,
                          "FirstTime": true,
                          "ChecklistItemId": 0]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    func documentDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func sortChecklists() {
        lists.sort({ checklist1, checklist2 in return
            checklist1.name.localizedStandardCompare(checklist2.name) == NSComparisonResult.OrderedAscending
        })
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Checklists") as [Checklist]
                unarchiver.finishDecoding()
                sortChecklists()
            }
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
}