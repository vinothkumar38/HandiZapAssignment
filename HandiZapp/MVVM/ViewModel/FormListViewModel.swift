//
//  FormListViewModel.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import Foundation
protocol FormListProtocol {
    var forms:[Form] { get }
    func refreshForms()
}
class FormListViewModel: FormListProtocol {

    var forms: [Form] = []
     func refreshForms() {
        self.forms = MyDBManager.shared.fetch(spec: DBConstants.allForm) ?? []
    }
}
