//
//  TableCells.swift
//  ExpressIssueSample
//
//  Created by PurushothamReddy on 22/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class EmployeeIDCell:UITableViewCell,ConfigurableCell {

    @IBOutlet weak var empIDTxtFld: UITextField!
    func configure(data id: String) {
        empIDTxtFld.text = id
    }
}

class EmployeeNameCell:UITableViewCell,ConfigurableCell {
    
    @IBOutlet weak var empNameLbl: UILabel!
    func configure(data emp:Employee) {
        empNameLbl.text = emp.Name
    }
}

class EmployeeDepartmentCell:UITableViewCell,ConfigurableCell {
    
    @IBOutlet weak var empDepartmentLbl: UILabel!
    func configure(data depart: String) {
        empDepartmentLbl.text = depart
    }
}

class AddItemCell:UITableViewCell,ConfigurableCell {
   
    @IBOutlet weak var addBtn: UIButton!
    func configure(data name:String) {
        addBtn.backgroundColor = .red
        addBtn.tintColor = .white
        addBtn.setTitle(name, for: UIControlState.normal)
    }
    
}
