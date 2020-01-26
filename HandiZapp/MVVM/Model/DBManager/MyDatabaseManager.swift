//
//  MyDatabaseManager.swift
//  Enviromux AP
//
//  Created by vinoth kumar on 28/12/19.
//  Copyright © 2019 vinoth kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MyDBManager:DatabaseManagerProtocol {
    
    
     var persistentContainer: NSPersistentContainer =
    {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HandiZapp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private var managedContext:NSManagedObjectContext
    {
        return persistentContainer.viewContext
    }
    static var shared:DatabaseManagerProtocol = MyDBManager()
    private init() {
        
    }
    
    
    func fetch<Spec>(spec: Spec) -> [Spec.T]? where Spec : FetchSpecsProtocol {
        do {
                if let result = try managedContext.fetch(spec.fetchRequest) as? [Spec.T]{
                    return result
                }
            }
        catch let error{
                   print(error)
                   return nil
        }
        return nil
    }
    
    
    func add<Add>(params: Add) -> Add.T where Add : AddToDBProtocol {
        let entity = NSEntityDescription.entity(forEntityName: params.entityName, in: managedContext)!
        let added = NSManagedObject(entity: entity, insertInto: managedContext) as! Add.T
        params.fillData(destination: added)
        self.saveChanges()
        return added
    }
    
    
    func delete<Spec>(spec: Spec) where Spec : FetchSpecsProtocol {
        if let result = self.fetch(spec: spec){
        for i in result{
            managedContext.delete(i as! NSManagedObject)
        }
        }
    }
    func saveChanges() {
        self.saveContext()
    }
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func isAlreadyPresent<Spec>(spec: Spec) -> Bool where Spec : FetchSpecsProtocol {
        if(self.fetch(spec: spec)?.count ?? 0 > 0){
            return true
        }
        return false
    }
}
