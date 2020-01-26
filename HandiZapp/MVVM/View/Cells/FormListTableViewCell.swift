//
//  FormListTableViewCell.swift
//  HandiZapp
//
//  Created by vinoth kumar on 26/01/20.
//  Copyright © 2020 vinoth kumar. All rights reserved.
//

import UIKit

class FormListTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var viewLabel:UILabel!
    @IBOutlet var rateLabel:UILabel!
    @IBOutlet var jobTermLabel:UILabel!
    @IBOutlet var inviteButton:UIButton!
    @IBOutlet var inboxButton:UIButton!
    @IBOutlet var fullView:UIView!
    @IBOutlet var optionButton:UIButton!


    var form:Form? {
        didSet {
            setupData()
        }
    }
    
    func setupData()  {
        self.nameLabel.text = form?.title
        self.dateLabel.text = form?.startDate
        self.viewLabel.text = "0 views"
        self.rateLabel.text = form?.rate
        self.jobTermLabel.text = form?.jobTerm
    
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.inboxButton.layer.borderColor = UIColor.init(named: "appColor")?.cgColor
        self.inboxButton.layer.borderWidth = 2.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
