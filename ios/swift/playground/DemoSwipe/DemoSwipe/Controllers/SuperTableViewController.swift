//
//  SuperTableViewController.swift
//  DemoSwipe
//
//  Created by George Sun on 4/28/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit
import SwipeCellKit

class SuperTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        // use the methods in this superclass 
        cell.delegate = self
        
        return cell
     }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deletionAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.updateModel(at: indexPath)
            // self.elements.remove(at: indexPath.row)
            // this is already taken care of by .destructive
            // self.tableView.reloadData()
        }
        deletionAction.image = UIImage(systemName: "link.icloud")
        
        return [deletionAction]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        // Update the data model
    }
}
