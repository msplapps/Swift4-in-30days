//
//  CoreDataManager.swift
//  EmpData
//
//  Created by Reddy on 18/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmpData")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
