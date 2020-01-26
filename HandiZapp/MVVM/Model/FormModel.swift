//
//  FormModel.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import Foundation
struct FormModel: Codable, AddToDBProtocol, Equatable {
    
    
    typealias T = Form
    
    var title:String?
    var startDate:String?
    var rate:String?
    var paymentMethod:String?
    var jobTerm:String?
    var desc:String?
    var currency:String?
    var budget:String?
    var id:String?
    
    var entityName: String {
        String(describing: T.self)
    }
    
    func fillData(destination: Form) {
        destination.title = self.title
        destination.rate = self.rate
        destination.paymentMethod = self.paymentMethod
        destination.jobTerm = self.jobTerm
        destination.currency = self.currency
        destination.budget = self.budget
        destination.startDate = self.startDate
        destination.id = self.id
        destination.desc = self.desc
    }
     init(withForm:Form) {
        self.title = withForm.title
        self.rate = withForm.rate
        self.paymentMethod = withForm.paymentMethod
        self.jobTerm = withForm.jobTerm
        self.currency = withForm.currency
        self.budget = withForm.budget
        self.startDate = withForm.startDate
        self.id = withForm.id
        self.desc = withForm.desc
    }
    init() {
        
    }
    
    

}
