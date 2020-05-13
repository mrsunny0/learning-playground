//
//  TableViewController.swift
//  DemoSwipe
//
//  Created by George Sun on 4/28/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit
import ChameleonFramework

class TableViewController: SuperTableViewController {
    var elements = [
        "A",
        "B",
        "C",
        "D",
        "E",
    ]
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let navBar = navigationController?.navigationBar {
            navBar.backgroundColor = UIColor.flatRed()
            
            title = "TITLE"
            
            // navBar.titleTextAttributes
            navBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor(contrastingBlackOrWhiteColorOn: navBar.backgroundColor, isFlat: true)!
            ]
            
            navBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: navBar.backgroundColor, isFlat: true)!
        }
            
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // call the original function to pass the custom cell datatype
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = elements[indexPath.row]
        
        // use the chameleon framework
        // cell.backgroundColor = UIColor.randomFlat()
        cell.backgroundColor = UIColor.flatWhite()?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(elements.count))
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
        
        print("AM I GETTING CALLED? \(counter)")
        counter += 1
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)        
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var userResponse = UITextField()
        
        let alert = UIAlertController(title: "Add an element", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            self.elements.append(userResponse.text!)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Type something"
            userResponse = textField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    // override a function from the superclass
    override func updateModel(at indexPath: IndexPath) {
         elements.remove(at: indexPath.row)
        // tableView.reloadData()  
    }
}
