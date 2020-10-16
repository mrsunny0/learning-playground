//
//  NSManagedObjectContext+Extensions.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
