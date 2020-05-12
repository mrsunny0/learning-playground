//
//  DescriptorModel.swift
//  App-Login-Bluetooth
//
//  Created by George Sun on 5/3/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation

struct DescriptorModel {
    let serviceUUID: String
    let charUUID: [String]
    
    func printChar() -> String {
        var returnString = ""
        for cU in charUUID {
            returnString += (cU + "\n")
        }
        return returnString
    }
}
