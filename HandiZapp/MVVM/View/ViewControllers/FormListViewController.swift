//
//  FormListViewController.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit

class FormListViewController: UIViewController {

    @IBOutlet var listTableView:UITableView!
    var viewModel:FormListProtocol = FormListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshForms()
        setupUI()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.refreshForms()
        listTableView.reloadData()
    }
    
    func setupUI() {
        listTableView.registerCell(cell: FormListTableViewCell.self)
        listTableView.delegate = self
        listTableView.dataSource = self
        let action = UITapGestureRecognizer(target: self, action: #selector(addAction))
        self.addRightBarItem(image: "Filter icon", actionGesture: action)

    }
    @objc func addAction() {
        let addVC:NewFormViewController = .getViewController(with: "Add new form")
        addVC.viewModel = NewFormViewModel()
        self.push(viewController: addVC)
    }
    @objc func optionAction(_ sender:UIButton) {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let action = UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
          let form = self.viewModel.forms[sender.tag]
          MyDBManager.shared.delete(spec: DBConstants.singleForm(id: form.id))
          MyDBManager.shared.saveChanges()
          self.viewModel.refreshForms()
          self.listTableView.reloadData()
        })
        let image = UIImage(named: "Trash icon")
        action.setValue(image, forKey: "image")

          alert.addAction(action)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
          }))

          self.present(alert, animated: true, completion: {
          })
    }
    func showSimpleActionSheet(controller: UIViewController) {
  
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FormListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(cell: FormListTableViewCell())
        cell.form = viewModel.forms[indexPath.row]
        cell.fullView.dropShadow()
        cell.optionButton.tag = indexPath.row
        cell.optionButton.addTarget(self, action: #selector(optionAction), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forms.count

    }

}
