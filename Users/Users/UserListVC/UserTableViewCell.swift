//
//  UserTableViewCell.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var userInitialLable: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var data: User?  {
        didSet {
            nameLabel.text = data?.name
            companyLabel.text = data?.company.name
            userInitialLable.text = String((data?.name.first)!)
            makeCircleView()
        }
    }
    
    func makeCircleView(){
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.layer.borderWidth = 0.5
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.backgroundColor = .random
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


}
