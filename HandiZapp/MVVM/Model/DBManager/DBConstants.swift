//
//  DBConstants.swift
//  Enviromux AP
//
//  Created by vinoth kumar on 12/12/19.
//  Copyright © 2019 vinoth kumar. All rights reserved.
//

import Foundation
enum DBConditions:String, Decodable {
    case equal = "="
    case contain = "contains[cd]"
//    case lesser
    case all
}
struct DBConstants {
    static var allForm:FetchSpecs<Form>{
        return FetchSpecs.init(key: "", value: "", condition: .all)
    }
    static func singleForm(id:String?) -> FetchSpecs<Form> {
        return FetchSpecs.init(key: "id", value: id ?? "", condition: DBConditions.equal)
    }
}
