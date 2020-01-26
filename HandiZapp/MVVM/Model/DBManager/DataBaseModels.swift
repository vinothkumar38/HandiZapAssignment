//
//  DataBaseModels.swift
//  Enviromux AP
//
//  Created by vinoth kumar on 29/12/19.
//  Copyright © 2019 vinoth kumar. All rights reserved.
//

import Foundation
import CoreData
struct FetchSpecs<T:NSManagedObject>:FetchSpecsProtocol {
    
    var key: String = ""
    var value: String = ""
    var condition: DBConditions = .all
    var fetchRequest:NSFetchRequest<NSFetchRequestResult>
    
    init(key:String,value:String,condition:DBConditions,sortKey:String = "id") {
        self.key = key
        self.value = value
        self.condition = condition
        let entity = String(describing: T.self)
        fetchRequest = NSFetchRequest.init(entityName: entity)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: sortKey, ascending: true)]
        if(condition != .all){
            let str = "\(key) \(condition.rawValue) %@"
            fetchRequest.predicate = NSPredicate.init(format: str,value)
        }
    }
}

