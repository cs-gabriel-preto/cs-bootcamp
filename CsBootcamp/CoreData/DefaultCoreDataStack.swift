//
//  DefaultCoreDataStack.swift
//  CsBootcamp
//
//  Created by Andre Rodrigues on 04/04/18.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import CoreData
import Foundation

final class DefaultCoreDataStack: CoreDataStack {
    
    static var shared: DefaultCoreDataStack = {
        return DefaultCoreDataStack()
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores { storeDescription, error in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy.overwrite
        
        return context
    }()
    
    private init() { }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
