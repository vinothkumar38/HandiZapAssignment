//
//  StringExtension.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit
extension Dictionary{
    var data:Data? {
        let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            return data
    }
}
extension String {
    var isvalidName:Bool{
        let invalidCharacters = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ").inverted
        return !(self.rangeOfCharacter(from: invalidCharacters, options: [], range: self.startIndex ..< self.endIndex) != nil)
    }
    
    func loadJson<T:Decodable>() -> T? {
        if let path = Bundle.main.path(forResource: self, ofType: "plist") {
            if let dictionary = NSDictionary.init(contentsOf:URL(fileURLWithPath: path)) as? [String:Any]{
                do{
                    if let data = dictionary.data {
                        let textfields = try JSONDecoder().decode(T.self, from: data)
                        return textfields
                    }
                }
                catch let error {
                    print(error)
                }
            }
        }
        return nil
    }
    
    var nib:UINib {
        return UINib.init(nibName: self, bundle: Bundle.main)
    }
}
