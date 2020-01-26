//
//  NewFormViewModel.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import Foundation
protocol NewFormViewModelProtocol {
    var textFields:[[TextFieldDetail]] { get }
    func saveForm()
}
class NewFormViewModel:NewFormViewModelProtocol {
    var textFields: [[TextFieldDetail]] = AppData.formTextFields
    
    func saveForm() {
        var form:FormModel? = FormModel()
        self.textFields.fill(with: &form)
        let id = ((MyDBManager.shared.fetch(spec: DBConstants.allForm)?.count ?? 0)+1
        ).description
        form?.id = id
        _ = MyDBManager.shared.add(params: form!)
    }
    
    
}
