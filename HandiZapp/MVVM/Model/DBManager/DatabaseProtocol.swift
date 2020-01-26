//
//  DatabaseProtocol.swift
//  Enviromux AP
//
//  Created by vinoth kumar on 29/12/19.
//  Copyright © 2019 vinoth kumar. All rights reserved.
//

import Foundation
import CoreData
protocol DatabaseManagerProtocol {
    func fetch<Spec:FetchSpecsProtocol>(spec:Spec) -> [Spec.T]?
    func add<Add:AddToDBProtocol>(params:Add) -> Add.T
    func isAlreadyPresent<Spec:FetchSpecsProtocol>(spec:Spec) -> Bool
    func delete<Spec:FetchSpecsProtocol>(spec:Spec)
    func saveChanges()
}
protocol FetchSpecsProtocol {
    associatedtype T
    var condition:DBConditions { get }
    var fetchRequest:NSFetchRequest<NSFetchRequestResult> { get }
}
protocol AddToDBProtocol {
    associatedtype T
    var entityName:String { get }
    func fillData(destination:T)
}
