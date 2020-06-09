//
//  CoreDataManager.swift
//  HotCoffeeApp
//
//  Created by George Sun on 6/9/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current) // cereated from extension
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    //MARK: - fetch
    private func fetchOrder(name: String) -> Order? {
        var orders = [Order]()
        
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name )
        
        do {
            orders = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return orders.first
        
    }
    
    //MARK: - delete
    func deleteOrder(name: String) {
        do {
            if let order = fetchOrder(name: name) {
                self.moc.delete(order)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: - get
    func getAllOrders() -> [Order] {
        var orders = [Order]()
        
        let orderRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do {
            orders = try self.moc.fetch(orderRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return orders
    }
    
    //MARK: - save
    func saveOrder(name: String, type: String) {
        let order = Order(context: self.moc)
        order.name = name
        order.type = type
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
}
