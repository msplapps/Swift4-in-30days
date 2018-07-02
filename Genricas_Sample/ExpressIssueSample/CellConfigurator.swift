//
//  CellConfigurator.swift
//  ExpressIssueSample
//
//  Created by PurushothamReddy on 22/05/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data:DataType)
    
}

protocol CellConfigurator {
   static var reuseID:String {get}
    func configure(cell:UIView)
}

//Genric to load all type of cells
class TableCellConfigurator<CellType:ConfigurableCell,DataType>:CellConfigurator where CellType.DataType == DataType,CellType:UITableViewCell {
    static var reuseID: String {
        return String(describing: CellType.self)
    }
    let item:DataType
    init(item:DataType){
        self.item = item
    }
    func configure(cell: UIView) {
        (cell as! CellType).configure(data:item)
    }
}
