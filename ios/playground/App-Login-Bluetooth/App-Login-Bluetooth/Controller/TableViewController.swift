//
//  TableViewController.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/2/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // data
    // var data: [DataModel] = []
    var data: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register nib
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        // add some generic amount
        data.append(1)
        data.append(1)
        data.append(1)
        tableView.reloadData()
    }
    
    
    // MARK: - Button actions
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        data.append(5)
        tableView.reloadData()
    }
    
    @IBAction func minusButton(_ sender: UIBarButtonItem) {
        data.remove(at: data.count-1)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create from .xib
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        
        cell.awakeFromNib()
        
        // create
        cell.label1?.text = "HELLO"
        cell.label2?.text = "feoai"
        cell.label3?.text = "GOIHRW"
        
        return cell
    }
    
    // MARK: - Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
