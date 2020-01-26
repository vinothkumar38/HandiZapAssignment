//
//  TextViewTableViewCell.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lineView: UIImageView!
    @IBOutlet weak var lineViewHeight: NSLayoutConstraint!


    
    var textChanged: ((String) -> Void)?
    var textFieldDetails:TextFieldDetail? {
        didSet {
            setupUI()
        }
    }
    var lastSate:Bool = true



    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
//        self.titleLabel.isHidden = true
        self.updateTitleVisibility(isVisible: false)
        


        // Initialization code
    }
    func setupUI() {
        titleLabel.text = textFieldDetails?.title
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
            let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }

    fileprivate func updateTitleVisibility(_ animated: Bool = false, isVisible:Bool) {
        
        
        if(lastSate != isVisible){
             lastSate = isVisible
        
             let alpha: CGFloat = isVisible ? 1.0 : 0.0
             let frame: CGRect = titleLabelRectForBounds(bounds, editing:false)
             let updateBlock = { () -> Void in
                        self.titleLabel.alpha = alpha
                        self.titleLabel.frame = frame
                    }
             let animationOptions: UIView.AnimationOptions = .curveEaseOut
             let duration = 0.3

             UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
             updateBlock()
             }, completion: nil)
        }
      }
    
    func updateLine(selected:Bool) {
        let color = selected ? UIColor.init(named: "appColor") : UIColor.lightGray
        let lineHeight = selected ? 2 : 1
        self.lineView.backgroundColor = color
        self.lineViewHeight.constant = CGFloat(lineHeight)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TextViewTableViewCell:UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        updateLine(selected: false)
        textFieldDetails?.value = textView.text
        self.updateTitleVisibility(isVisible: true)
        if(textView.text == ""){
            self.updateTitleVisibility(isVisible: false)
            textView.text = "Form Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateLine(selected: true)
        if let value = textFieldDetails?.value,value != "" {
            self.updateTitleVisibility(isVisible: true)

            textView.text = value
            textView.textColor = UIColor.init(named: "appColor")

        }
        else{
            self.updateTitleVisibility(isVisible: true)
            textView.text = ""
            textView.textColor = UIColor.init(named: "appColor")

        }
    }
    func textViewDidChange(_ textView: UITextView) {
        textFieldDetails?.value = textView.text
        textChanged?(textView.text)
    }
}
