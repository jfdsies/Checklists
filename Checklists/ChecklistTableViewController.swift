//
//  ChecklistTableViewController.swift
//  Checklists
//
//  Created by sora on 14/10/26.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import UIKit

class ChecklistTableViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [ChecklistItem]()
    var checklist: Checklist!
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as UINavigationController
            
            let controller = navigationController.topViewController as ItemDetailViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as UINavigationController
            
            let controller = navigationController.topViewController as ItemDetailViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
//    func saveChecklistItems() {
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        
//        archiver.encodeObject(items, forKey: "ChecklistItems")
//        archiver.finishEncoding()
//        
//        data.writeToFile(dataFilePath(), atomically: true)
//    }
//    
//    func loadChecklistItems() {
//        let path = dataFilePath()
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            if let data = NSData(contentsOfFile: path) {
//                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                items = unarchiver.decodeObjectForKey("ChecklistItems") as [ChecklistItem]
//                unarchiver.finishDecoding()
//            }
//        }
//    }
//    
//    func documentsDirectory() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
//        
//        return paths[0]
//    }
//    
//    func dataFilePath() -> String {
//        return "\(documentsDirectory())/Checklists.plist"
//    }
    
    func addItemViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        if let index = find(checklist.items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        
        checklist.items.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    required init(coder aDecoder: NSCoder) {
//        items = [ChecklistItem]()
//        super.init(coder: aDecoder)
//        loadChecklistItems()
// }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        checklist.items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = 44
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return checklist.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let item = checklist.items[indexPath.row]
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem){
        let label = cell.viewWithTag(1001) as UILabel

        if item.checked {
            label.text = "✔︎"
        } else {
            label.text = ""
        }
        label.textColor = view.tintColor
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem){
        let label = cell.viewWithTag(1000) as UILabel
        label.text = "\(item.itemId): \(item.text)"
    }

}
