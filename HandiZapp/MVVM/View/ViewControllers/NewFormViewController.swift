//
//  NewFormViewController.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit

class NewFormViewController: UIViewController {

    
    @IBOutlet var textFieldTableView:UITableView!
    var viewModel:NewFormViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
        self.setCustomBack()

        let action = UITapGestureRecognizer(target: self, action: #selector(sendAction))
        self.addRightBarItem(image: "Send", actionGesture: action,isImage: false)


        textFieldTableView.delegate = self
        textFieldTableView.dataSource = self
        textFieldTableView.registerCell(cell: TextFieldTableViewCell.self)
        textFieldTableView.registerCell(cell: TextViewTableViewCell.self)

    }
    @objc func sendAction() {
        
        self.view.endEditing(true)
        
        var isError = false
        for i in 0..<viewModel.textFields.count {
            let index = IndexPath.init(row: i, section: 0)
            if let cell = self.textFieldTableView.cellForRow(at: index) as? TextFieldTableViewCell {
                if(cell.textField1.text == "") {
                    cell.textField1.errorMessage = cell.textFieldDetails[0].title
                    cell.required1Label.isHidden = false
                    isError = true
                }
                if(cell.textField2.text == "") {
                    if(cell.textFieldDetails.count > 1){
                        cell.textField2.errorMessage = cell.textFieldDetails[1].title
                        cell.required2Label.isHidden = false
                        isError = true
                    }
                }
            }
        }
        if(isError){
            return
        }
    
        self.viewModel.saveForm()
        self.navigationController?.popViewController(animated:false)
    }

}
extension NewFormViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.textFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentDetails = viewModel.textFields[indexPath.row]
        if let current = viewModel.textFields[indexPath.row].first {
            switch current.inputType {
            case .textField,.drop:
                let cell = tableView.getCell(cell: TextFieldTableViewCell())
                cell.textFieldDetails = currentDetails
                return cell
                
            case .textView:
                let cell = tableView.getCell(cell: TextViewTableViewCell())
                cell.textFieldDetails = current
                cell.textChanged {[weak tableView] (_) in
                            tableView?.beginUpdates()
                            tableView?.endUpdates()
                }
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    
}
