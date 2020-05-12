//
//  SearchController.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/3/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceController: UIViewController {
    
    // tableView
    @IBOutlet weak var tableView: UITableView!

    // elements
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // devices
    var device: DeviceModel!
    var deviceFound = false
    private var centralManager: CBCentralManager!
    var descriptors = [DescriptorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // register nib
        tableView.register(UINib(nibName: "BluetoothDescriptorCell", bundle: nil), forCellReuseIdentifier: "ResuableDescriptorCell")
        
        // adjust tableView
        tableView.rowHeight = 40
        tableView.separatorStyle = .none

        // add some dumy data
        descriptors.append(DescriptorModel(serviceUUID: "HELLO", charUUID: ["EFOHE"]))
        descriptors.append(DescriptorModel(serviceUUID: "HELLO", charUUID: ["fewaoih"]))
        
        // load data
        tableView.reloadData()
        
        // hide cancel button
        // navigationItem.right
        
        // hide backspace
        // navigationItem.hidesBackButton = true
        
    }
    
    //MARK: - Bar Buttons
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToFind", sender: self)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
    }
}

//MARK: - TableView Data Source
extension DeviceController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResuableDescriptorCell", for: indexPath) as! BluetoothDescriptorCell
        
        cell.serviceLabel.text = "HELLO"
        cell.charLabel.lineBreakMode = .byWordWrapping
        cell.charLabel.numberOfLines = 0
        cell.charLabel.text = "HELLO\nWORLD"
        
        return cell
    }
}

//MARK: - TableView Delegate Methods
extension DeviceController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

//MARK: - Bluetooth
//extension DeviceController: CBCentralManagerDelegate {
//    // Power state
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        print("Central state update")
//        if central.state != .poweredOn {
//            print("Central is not powered on")
//        } else {
//            print("Central scanning")
//        }
//    }
//    
//    // Device
//}
