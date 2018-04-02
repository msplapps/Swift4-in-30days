//
//  LocationCell.swift
//  Container
//
//  Created by Reddy on 02/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell, ReusableIdentifier {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 10.0, *) {
            name.adjustsFontForContentSizeCategory = true
            location.adjustsFontForContentSizeCategory = true
        }
    
    }
    
}
extension LocationCell:ConfigurableCell{
    func configure(object:Location){
        name.text = object.name
        location.text = String("\(object.latitude),\(object.longitude)")
    }
}
