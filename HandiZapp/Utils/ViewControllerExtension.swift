//
//  ViewControllerExtension.swift
//  HandiZapp
//
//  Created by vinoth kumar on 25/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    private static var mainStoryBoard:UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main)
    }
    class func getViewController<T:UIViewController> (with title:String = "") -> T {
        let string = String.init(describing: T.self)
        let myViewController = self.mainStoryBoard.instantiateViewController(withIdentifier: string)
        myViewController.title = title
        return myViewController as! T
    }
    
    func addRightBarItem(image:String,actionGesture:UITapGestureRecognizer,isImage:Bool = true){

        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        if let imgBackArrow = UIImage(named: image) {
            imageView.image = imgBackArrow
        }
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
        label.text = image
        label.textColor = .white
        if(isImage){
            view.addSubview(imageView)
        }
        else{
            view.addSubview(label)
        }
        view.addGestureRecognizer(actionGesture)
        let barbutton = UIBarButtonItem(customView: view )
        var rightItems = self.navigationItem.rightBarButtonItems ?? []
        rightItems.append(barbutton)
        self.navigationItem.rightBarButtonItems = rightItems
    }
    
    func setCustomBack(image:String = "Back Button") {

        //your custom view for back image with custom size
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        if let imgBackArrow = UIImage(named: image) {
            imageView.image = imgBackArrow
            imageView.contentMode = .center
        }
        view.addSubview(imageView)
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backAction))
        view.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func push(viewController:UIViewController) {
           guard let navigation = self.navigationController else {
               return
           }
           navigation.pushViewController(viewController, animated: true)
    }
}
extension UIViewController: UIGestureRecognizerDelegate {
    
}
