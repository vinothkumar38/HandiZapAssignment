//
//  Form+CoreDataProperties.swift
//  
//
//  Created by vinoth kumar on 27/01/20.
//
//

import Foundation
import CoreData


extension Form {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Form> {
        return NSFetchRequest<Form>(entityName: "Form")
    }

    @NSManaged public var budget: String?
    @NSManaged public var currency: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var jobTerm: String?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var rate: String?
    @NSManaged public var startDate: String?
    @NSManaged public var title: String?

}
