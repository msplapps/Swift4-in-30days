//
//  TableViewModel.swift
//  ExpressIssueSample
//
//  Created by PurushothamReddy on 22/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

typealias employeeCellConfig = TableCellConfigurator<EmployeeIDCell,String>
typealias employeeNameConfig = TableCellConfigurator<EmployeeNameCell,Employee>
typealias empdeptNameConfig = TableCellConfigurator<EmployeeDepartmentCell,String>
typealias addItemCellConfig = TableCellConfigurator<AddItemCell,String>

class TableViewModel {
    
    let items:[CellConfigurator] = [
        employeeCellConfig.init(item: "098592"),
        employeeNameConfig.init(item: Employee(Name:"Purushotham",ID:"1234")),
        empdeptNameConfig.init(item: "CHindia"),
        TableCellConfigurator<AddItemCell,String>.init(item: "Add Item")
   //     addItemCellConfig.init(item: "Add Another Item")
    ]
}
