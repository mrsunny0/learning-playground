//
//  DataModel.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/2/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import CoreBluetooth

struct DeviceModel {
    // device
    let device: CBPeripheral
    let deviceRSSI: NSNumber

    // device descriptions
    var deviceName: String? {
        return device.name
    }
    var deviceUUID: String? {
        return device.identifier.uuidString
    }
}
