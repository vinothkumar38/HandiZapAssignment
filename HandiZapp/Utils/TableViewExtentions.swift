//
//  TableViewExtentions.swift
//  Enviromux AP
//
//  Created by vinoth kumar on 11/12/19.
//  Copyright © 2019 vinoth kumar. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func registerCell(cell:AnyClass) {
        addEmptyFooter()
        let string = String.init(describing: cell.self)
        self.register(string.nib, forCellReuseIdentifier: string)
    }
    private func addEmptyFooter() {
        let view = UIView()
        self.tableFooterView = view
    }
    func getCell<T:UITableViewCell> (cell:T) -> T {
        let string = String.init(describing: T.self)
        let cell = self.dequeueReusableCell(withIdentifier: string) as! T
        return cell
    }
}
extension UIView {
    func dropShadow(color:UIColor = UIColor.lightGray, height :CGFloat = 2,blur : Int = 15) {
          
          self.layer.shadowColor = color.cgColor
          self.layer.shadowOpacity = 0.5
          self.layer.shadowOffset = CGSize.init(width: 0, height: height)
          self.layer.shadowRadius = CGFloat(blur/2)
          self.layer.masksToBounds = false
      }
}
