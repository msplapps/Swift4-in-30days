//
//  EmployeeCell.swift
//  EmpData
//
//  Created by Reddy on 19/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userIdlLbl: UILabel!
    
    
     static let reuseIdentifier = "empCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    func configure(withViewModel viewModel: Employees) {
       nameLbl.text = viewModel.name
        titleLbl.text = viewModel.title
        userIdlLbl.text = "ID: \(String(describing: viewModel.id!))"
        userNameLbl.text = "User: \(String(describing: viewModel.username!))"
    }
    
}
