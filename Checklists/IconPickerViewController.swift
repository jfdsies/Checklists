//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by sora on 14/11/16.
//  Copyright (c) 2014年 sora. All rights reserved.
//

import Foundation
import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickerViewcontroller, didPickIcon iconName: String)
}

class IconPickerViewcontroller: UITableViewController {
    let icons = [
        "No Icon", "Appointments", "Birthdays", "Chores", "Drinks",
        "Folder", "Groceries","Inbox", "Photos", "Trips"]
        
    weak var delegate: IconPickerViewControllerDelegate?
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IconCell") as UITableViewCell
        
        let iconName = icons[indexPath.row]
        cell.textLabel.text = iconName
        cell.imageView.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPickIcon: iconName)
        }
    }
}