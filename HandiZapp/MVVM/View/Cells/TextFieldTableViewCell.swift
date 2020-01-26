//
//  TextFieldTableViewCell.swift
//  HandiZapp
//
//  Created by vinoth kumar on 25/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textField1: SkyFloatingLabelTextField!
    @IBOutlet weak var textField2: SkyFloatingLabelTextField!

    @IBOutlet weak var required1Label: UILabel!
    @IBOutlet weak var required2Label: UILabel!

    
    
    var textFieldDetails:[TextFieldDetail] = [] {
        didSet {
            setupUI()
            setupKeyBoard()
        }
    }
    private var currentDetail:TextFieldDetail {
        return textFieldDetails[currentIndex]
    }
    private var currentIndex:Int = 0
    var dropDownData:[String] {
        currentDetail.dropData
    }
    var currenLabel:UILabel {
        if(currentIndex == 0){
            return required1Label
        }
        else{
            return required2Label

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField1.delegate = self
        textField1.tag = 0
        textField2.delegate = self
        textField2.tag = 1
        textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Initialization code
    }
    func setupUI() {
        
        required1Label.isHidden = true
        required2Label.isHidden = true

        textField1.isHidden = !(textFieldDetails.count > 0)
        textField2.isHidden = !(textFieldDetails.count > 1)
        
        if let first = textFieldDetails.first{
            textField1.placeholder = first.title
            textField1.text = first.value
            textField1.isUserInteractionEnabled = first.isEnabled ?? true
        }
     
        if(textFieldDetails.count > 1){
        textField2.placeholder = textFieldDetails[1].title
            textField2.text = textFieldDetails[1].value
            textField2.isUserInteractionEnabled = textFieldDetails[1].isEnabled ?? true

        }

        
    }
    func setupKeyBoard() {
        self.textField1.keyboardType = self.textFieldDetails[self.textField1.tag].contentType == .number ? .numberPad : .asciiCapable;
        if(self.textFieldDetails.count > 1){
            self.textField2.keyboardType = self.textFieldDetails[self.textField2.tag].contentType == .number ? .numberPad : .asciiCapable;
        }
    }
    func getDropView() -> UIPickerView {
           let dropDown = UIPickerView.init()
           dropDown.delegate = self
           dropDown.dataSource = self
           return dropDown
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TextFieldTableViewCell: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if let errorField = textField as? SkyFloatingLabelTextField {
                if(textField.text == "" && self.currentDetail.isRequired){
                    errorField.errorMessage = textField.placeholder
                    self.currenLabel.isHidden = false
                }
                else{
                    self.currenLabel.isHidden = true
                    errorField.errorMessage = ""
                }
            }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentIndex = textField.tag
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentIndex = textField.tag
         switch currentDetail.inputType {
            case .drop:
                   let source = self.getDropView()
                   if let index = dropDownData.firstIndex(where: {$0 == textField.text}){
                       source.selectRow(index, inComponent: 0, animated: true)
                   }
                   else{
                    textField.text = dropDownData.first
                    self.currentDetail.value = textField.text
                    
                    (textField as? SkyFloatingLabelTextField)?.errorMessage = ""
                    self.currenLabel.isHidden = true


                   }
                   textField.inputView = source
         default:
             break

        }
        return true
    }
    
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        (textField as? SkyFloatingLabelTextField)?.errorMessage = ""
        self.currenLabel.isHidden = true

        let textFieldDetail = self.currentDetail
        textFieldDetail.value = textField.text
    
        
    }
}
extension TextFieldTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return self.dropDownData.count
     }
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return self.dropDownData[row]
     }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(currentIndex == 0){
        self.textField1.text = self.dropDownData[row]
        }
        else{
            self.textField2.text = self.dropDownData[row]
        }
        self.currentDetail.value = self.dropDownData[row]
    }
}
