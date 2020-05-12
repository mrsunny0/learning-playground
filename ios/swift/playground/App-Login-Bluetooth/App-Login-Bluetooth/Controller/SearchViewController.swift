//
//  TableViewController.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/2/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import UIKit
import CoreBluetooth

class SearchViewController: UITableViewController {
    
    // data
    var deviceList: [DeviceModel] = []
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register nib
        tableView.register(UINib(nibName: "DeviceCell", bundle: nil), forCellReuseIdentifier: "ReusableDeviceCell")
        
        // customize tableView
        tableView.rowHeight = 80
        // tableView.separatorStyle = .none
        
        // initialize bluetooth
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create from .xib
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableDeviceCell", for: indexPath) as! DeviceCell
        
        // customize
        let device = deviceList[indexPath.row]
        cell.deviceLabel.text = device.deviceName
        cell.UUIDLabel.text = device.deviceUUID
        cell.RSSILabel.text = String(format: "RSSI: %@ dB", device.deviceRSSI.stringValue)
        
        return cell
    }
    
    // MARK: - Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // select animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // access peripheral
        peripheral = deviceList[indexPath.row].device
        
        // set its delegate methods
        peripheral.delegate = self
        
        // connect to bluetooth device
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
        
        // go back to main view, and pass device
    }
}

//MARK: - Bluetooth Delegates
extension SearchViewController: CBPeripheralDelegate, CBCentralManagerDelegate {

    // Power state
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            print("Central scanning")
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : false])
        }
    }
    
    // Discover
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let _ = peripheral.name {
            deviceList.append(DeviceModel(device: peripheral, deviceRSSI: RSSI))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Discover Services
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral {
            if let name = peripheral.name {
                print("Connected to \(name)")
                
                // search for services
                peripheral.discoverServices(nil)
            }
        }
    }
    
    // Found Services
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("Service name: \(service.uuid.uuidString)")
                
                // search for characteristics
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    // Found Characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Characteristic name: \(characteristic.uuid.uuidString)")
                
                // connect to characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    // On Notify Characteristics
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
//        <#code#>
//    }
}
