//
//  Constants.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import Foundation
struct DropInData:Decodable {
    var rate:[String]
    var paymentMethod:[String]
    var jobTerm:[String]
    var startDate:[String] {
        var date = Date()
        var final = ["Today"]
        for i in 1..<6 {
            
            let timeinterval = i*24*60*60
            date = date.addingTimeInterval(TimeInterval(timeinterval))
            let dateFormat = DateFormatter.init()
            dateFormat.dateFormat = "EEEE d MMM"
            final.append(dateFormat.string(from: date))
        }
        return final
    }
    
}
struct AppData {
     static var fullDropData:DropInData? {
        "DropInData".loadJson()
    }
    private static var fullData:TextFieldData? {
        return "TextFieldData".loadJson()
    }
    static var formTextFields:[[TextFieldDetail]] {
        return AppData.fullData?.formFields ?? []
    }
}
