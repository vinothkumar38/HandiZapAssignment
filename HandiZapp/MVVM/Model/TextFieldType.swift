//
//  TextFieldType.swift
//  HandiZapp
//
//  Created by vinoth kumar on 25/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit
//enum CellType:String, Codable {
//    case single
//    case double
//    case textView
//}
enum InputType:String, Codable {
    case textField
    case drop
    case textView
}
enum TextFieldContent : String,Decodable {
    case text
    case number
}
struct TextFieldData : Decodable {
    var formFields:[[TextFieldDetail]]
}
class TextFieldDetail : Decodable {
    
    var key:String
    var title:String
    var contentType:TextFieldContent
    var inputType:InputType
    var value:String?
    var isEnabled:Bool?
    var image:String?
    var isRequired:Bool
    
    
    var dropData:[String] {
        switch key {
        case "rate":
            return AppData.fullDropData?.rate ?? []
        case "paymentMethod":
            return AppData.fullDropData?.paymentMethod ?? []
        case "jobTerm":
            return AppData.fullDropData?.jobTerm ?? []
        case "startDate":
            return AppData.fullDropData?.startDate ?? []
        default:
            return []
        }
    }

}
extension Array where Element == [TextFieldDetail] {
    private var dictionary:[String:Any] {
        var final = [String:Any]()
        for text in self {
            for input in text{
                final[input.key] = input.value
            }
        }
        return final
    }
    
    func fill<T:Codable>(with model:inout T?) {
        do{
            if let data = self.dictionary.data{
                let updated:T = try JSONDecoder().decode(T.self, from: data)
                model = updated
                return;
            }
        }
        catch let error {
            print("Decode Error:\(error)")
            return;
        }
    }
}
